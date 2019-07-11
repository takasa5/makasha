class PostsController < ApplicationController
  include SessionsHelper
  protect_from_forgery
  before_action :twitter_client, only: [:create]

  def create
    user = current_user
    # 最新の同一データを取得
    @last_post = Post.where(
      song: params[:post][:song],
      artist: params[:post][:artist],
      posted_by: user.twitterid
    ).last
    if @last_post.nil? # ない場合
      @post = Post.new(
        song: params[:post][:song],
        artist: params[:post][:artist],
        posted_by: user.twitterid,
        count: 1,
        period_before: 0
      )
    else # ある場合
      # 前のデータを参照して登場回数，スパンを入れる
      @post = Post.new(
        song: params[:post][:song],
        artist: params[:post][:artist],
        posted_by: user.twitterid,
        count: @last_post.count + 1,
        period_before: (Time.current.in_time_zone('Japan') - @last_post.created_at.in_time_zone('Japan')) / 60 / 60
      )
    end
    @post.save!
    # ツイート
    if params[:post][:twitter] == "1"
      make_tweet(user.template, @post)
      @client.update(@tweet)
      # puts @tweet
    end

    redirect_to root_path
  end

  def update
    if params["delete"].nil? # 編集
      post = Post.find(params[:id])
      current_user = post.posted_by
      before_song = post.song
      before_artist = post.artist
      # 最新の同一データを取得
      last_post = Post.where(
        id: 1..(params[:id].to_i - 1),
        song: params[:post][:song],
        artist: params[:post][:artist],
        posted_by: current_user
      ).last
      if last_post.blank? # ない場合
        post.update(
          song: params[:post][:song],
          artist: params[:post][:artist],
          count: 1,
          period_before: 0
        )
      else # ある場合
        post.update(
          song: params[:post][:song],
          artist: params[:post][:artist],
          count: last_post.count + 1,
          period_before: (post.created_at.in_time_zone('Japan') - last_post.created_at.in_time_zone('Japan')) / 60 / 60
        )
      end
      # 編集後，元データに関連するデータを修正
      reload_posts(params[:id], before_song, before_artist, current_user)
      # 新しいデータに関連するデータを修正
      reload_posts(params[:id], params[:post][:song], params[:post][:artist], current_user)
    else # 削除
      post = Post.find(params[:id])
      post.destroy
      current_user = post.posted_by
      # 削除後のテーブルを正しくする
      reload_posts(params[:id], params[:post][:song], params[:post][:artist], current_user)
    end
    redirect_to root_path
  end

  private

  def reload_posts(id, song, artist, current_user)
    # 編集されたデータ以降のデータのperiod_before, countの変更
    update_targets = Post.where(
      id: (id.to_i + 1)..Float::INFINITY,
      song: song,
      artist: artist,
      posted_by: current_user
    )
    if not update_targets.blank? # 該当データがあった場合
      # 編集データ以前のデータのうち最新のものを取得
      last_post = nil
      if id.to_i != 1
        last_post = Post.where(
          id: 1..(id.to_i - 1),
          song: song,
          artist: artist,
          posted_by: current_user
        ).last
      end
      for target in update_targets do
        # 一つ前の同一曲データをもとに該当データを更新
        # last_postがない場合(最初のデータを消した場合)
        if last_post.blank?
          target.update(
            period_before: 0,
            count: 1
          )
        else # last_postがある場合
          target.update(
            period_before: (target.created_at.in_time_zone('Japan') - last_post.created_at.in_time_zone('Japan')) / 60 / 60,
            count: last_post.count + 1,
          )
        end
        last_post = target
      end
    end
  end

  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.mom[:api_key]
      config.consumer_secret = Rails.application.credentials.mom[:api_secret]
      config.access_token = current_user_token
      config.access_token_secret = current_user_secret
    end
  end

  def make_tweet(template, post)
    @tweet = template.gsub!("%artist%", post.artist).gsub!("%song%", post.song)
    @tweet += " #Makasha " + root_url(only_path: false) + "users/" + current_user.twitterid
  end
end
