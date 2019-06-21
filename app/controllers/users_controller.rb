class UsersController < ApplicationController
  def home
    @user = User.find_by(twitterid: params[:twitterid])
    @posts = Post.where(posted_by: params[:twitterid])

    render 'home.index.erb'
  end

  def setting

    render 'setting.html.erb'
  end
end