class PagesController < ApplicationController
  # 主にホーム画面のコントローラ
  include SessionsHelper, UsersHelper
  # protect_from_forgery except: :chart_update
  before_action :twitter_client, only: [:refresh_icon]

  def home(list_num: 10)
    if logged_in?
      @user = current_user
      if @user.nil?
        log_out
        redirect_to lp_path
      else
        cnt = Post.where(posted_by: @user.twitterid).count
        @records = cnt
        if cnt % list_num == 0
          @count = cnt / list_num
        else
          @count = cnt / list_num + 1
        end
        @posts = Post.where(posted_by: @user.twitterid).reverse_order.limit(list_num)
        @index = 1
        if cnt != 0
          get_record_stat current_user.twitterid
          @data_exists = true
        else
          @data_exists = false
        end
      end
    else
      redirect_to lp_path
    end
  end

  def move(list_num: 10)
    @user = params[:user]
    @index = params[:index]
    @btn = (params[:index].to_i + 1).to_s
    cnt = Post.where(posted_by: @user).count
    if cnt % list_num == 0
      @count = cnt / list_num
    else
      @count = cnt / list_num + 1
    end
    @start = params[:index].to_i * list_num
    @posts = Post.where(posted_by: @user).reverse_order.offset(@start).limit(list_num)
  end

  def edit
    @post = Post.find(params[:post])
  end

  # 設定ビュー
  def setting
    @user = current_user

    render 'setting.html.erb'
  end

  # アカウント削除
  def delete_account
    @user = current_user
    # ログアウト処理
    log_out
    reset_session
    # postの削除
    Post.where(posted_by: @user.twitterid).destroy_all
    # ユーザデータの削除
    @user.destroy
    
    render 'deleted.html.erb'
  end

  # グラフの更新
  def chart_update()
    get_record_stat(params[:user], range: params[:range])
  end
  
  # ツイッターアイコンの再取得
  def refresh_icon
    current_user.update(
      image_url: @client.user.profile_image_url
    )
    @user = current_user
    render 'setting.html.erb'
  end

  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.mom[:api_key]
      config.consumer_secret = Rails.application.credentials.mom[:api_secret]
      config.access_token = current_user_token
      config.access_token_secret = current_user_secret
    end
  end

end
