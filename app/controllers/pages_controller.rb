class PagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user()
      if @user.nil?
        session[:user_id] = nil
      else
        @count = Post.where(posted_by: @user.twitterid).count / 8 + 1
        @posts = Post.where(posted_by: @user.twitterid).reverse_order.limit(8)
      end
      @index = 1
    end
  end

  def move
    @user = current_user()
    @index = params[:index]
    @btn = (params[:index].to_i + 1).to_s
    @count = Post.where(posted_by: @user.twitterid).count / 8 + 1
    @start = params[:index].to_i * 8
    @posts = Post.where(posted_by: @user.twitterid).reverse_order.offset(@start).limit(8)
  end
end
