class UsersController < ApplicationController
  include SessionsHelper

  def home
    @user = User.find_by(twitterid: params[:twitterid])
    @posts = Post.where(posted_by: params[:twitterid])

    render 'home.index.erb'
  end

  def setting
    @user = current_user

    render 'setting.html.erb'
  end

  # プロフィール，テンプレートの更新
  def update
    current_user.update(
      profile: params[:user][:profile],
      template: params[:user][:template]
    )
  end
end