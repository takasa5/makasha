class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from_auth(auth)
    # セッションの作成
    session[:name] = auth[:info][:nickame]
    session[:user_id] = auth[:uid]
    session[:user_token] = auth[:credentials][:token]
    session[:user_secret] = auth[:credentials][:secret]
    flash[:notice] = "ユーザ認証が完了しました。"
    redirect_to root_path
  end

  def destroy
    reset_session
    flash[:notice] = "ログアウトしました。"
    redirect_to root_path
  end
end
