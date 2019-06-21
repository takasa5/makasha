class PagesController < ApplicationController
  include SessionsHelper

  def home
    if logged_in?
      @user = current_user
      if @user.nil?
        session[:user_id] = nil
      else
        cnt = Post.where(posted_by: @user.twitterid).count
        if cnt % 8 == 0
          @count = cnt / 8
        else
          @count = cnt / 8 + 1
        end
        @posts = Post.where(posted_by: @user.twitterid).reverse_order.limit(8)
      end
      @index = 1
    end
  end

  def move
    @user = current_user
    @index = params[:index]
    @btn = (params[:index].to_i + 1).to_s
    cnt = Post.where(posted_by: @user.twitterid).count
    if cnt % 8 == 0
      @count = cnt / 8
    else
      @count = cnt / 8 + 1
    end
    @start = params[:index].to_i * 8
    @posts = Post.where(posted_by: @user.twitterid).reverse_order.offset(@start).limit(8)
  end

  def edit
    @post = Post.find(params[:post])
  end
end
