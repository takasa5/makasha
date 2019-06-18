class PostsController < ApplicationController
  def create
    @last_post = Post.where(
      song: params[:post][:song],
      artist: params[:post][:artist],
      posted_by: current_user.twitterid
    ).first
    if @last_post.nil?
      @post = Post.new(
        song: params[:post][:song],
        artist: params[:post][:artist],
        posted_by: current_user.twitterid,
        count: 1,
        period_before: nil
      )
    else
      @post = Post.new(
        song: params[:post][:song],
        artist: params[:post][:artist],
        posted_by: current_user.twitterid,
        count: @last_post.count + 1,
        period_before: (Time.current.in_time_zone('Japan') - @last_post.created_at.in_time_zone('Japan')) / 60 / 60
      )
    end
    @post.save!
    redirect_to root_path
  end
end
