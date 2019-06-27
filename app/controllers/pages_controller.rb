class PagesController < ApplicationController
  # 主にホーム画面のコントローラ
  include SessionsHelper, UsersHelper

  def home
    if logged_in?
      @user = current_user
      if @user.nil?
        session[:user_id] = nil
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
      get_record_stat current_user
    else
      redirect_to lp_path
    end
  end

  def move
    @user = params[:user]
    @index = params[:index]
    @btn = (params[:index].to_i + 1).to_s
    cnt = Post.where(posted_by: @user).count
    if cnt % 8 == 0
      @count = cnt / 8
    else
      @count = cnt / 8 + 1
    end
    @start = params[:index].to_i * 8
    @posts = Post.where(posted_by: @user).reverse_order.offset(@start).limit(8)
  end

  def edit
    @post = Post.find(params[:post])
  end

  # 設定ビュー
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

  private
  
end
