class SessionsController < ApplicationController
  include SessionsHelper

  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from_auth(auth)
    # セッションの作成
    session[:name] = auth[:info][:nickame]
    session[:user_id] = auth[:uid]
    # 記憶
    remember(user, auth)
    flash[:notice] = "ユーザ認証が完了しました。"
    redirect_to root_path
  end

  def destroy
    log_out if logged_in?
    reset_session
    flash[:notice] = "ログアウトしました。"
    redirect_to root_path
  end
end
