module SessionsHelper
  # ユーザーを永続的セッションに記憶する
  def remember(user, auth)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
    cookies.permanent.signed[:token] = auth[:credentials][:token]
    cookies.permanent.signed[:secret] = auth[:credentials][:secret]
  end

  # 永続的セッションを破棄
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    cookies.delete(:token)
    cookies.delete(:secret)
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(uid: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(uid: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def log_in
    session[:user_id] = user.id
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user_token
    cookies.signed[:token]
  end

  def current_user_secret
    cookies.signed[:secret]
  end

end
