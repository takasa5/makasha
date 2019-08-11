class UsersController < ApplicationController
  include SessionsHelper, UsersHelper

  def home(list_num: 10)
    @user = User.find_by(twitterid: params[:twitterid])
    if @user.nil?
      # ユーザーは存在しません処理
    else
      cnt = Post.where(posted_by: @user.twitterid).count
      @records = cnt
      if cnt % list_num == 0
        @count = cnt / list_num
      else
        @count = cnt / list_num + 1
      end
      @posts = Post.where(posted_by: @user.twitterid).reverse_order.limit(list_num)
    end
    @index = 1
    if cnt != 0
      get_record_stat @user.twitterid
      @data_exists = true
    else
      @data_exists = false
    end
    render template: "pages/home"
  end

  # プロフィール，テンプレートの更新
  def update
    current_user.update(
      name: params[:user][:name],
      profile: params[:user][:profile],
      template: params[:user][:template],
      indicate_twitter: params[:user][:indicate_twitter]
    )
  end
  
end