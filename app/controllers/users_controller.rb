class UsersController < ApplicationController
  include SessionsHelper, UsersHelper

  def home
    @user = User.find_by(twitterid: params[:twitterid])
    if @user.nil?
      # ユーザーは存在しません処理
    else
      cnt = Post.where(posted_by: @user.twitterid).count
      @records = cnt
      if cnt % 8 == 0
        @count = cnt / 8
      else
        @count = cnt / 8 + 1
      end
      @posts = Post.where(posted_by: @user.twitterid).reverse_order.limit(8)
    end
    @index = 1
    get_record_stat @user.twitterid
    render template: "pages/home"
  end

  # プロフィール，テンプレートの更新
  def update
    current_user.update(
      name: params[:user][:name],
      profile: params[:user][:profile],
      template: params[:user][:template]
    )
  end
  
end