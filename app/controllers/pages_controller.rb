class PagesController < ApplicationController
  # 主にホーム画面のコントローラ
  include SessionsHelper, UsersHelper
  # protect_from_forgery except: :chart_update

  def home(list_num: 10)
    if logged_in?
      @user = current_user
      if @user.nil?
        session[:user_id] = nil
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
      get_record_stat current_user.twitterid
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

  # プロフィール，テンプレートの更新
  def update
    current_user.update(
      profile: params[:user][:profile],
      template: params[:user][:template]
    )
  end

  # グラフの更新
  def chart_update()
    get_record_stat(params[:user], range: params[:range])
  end
  
end
