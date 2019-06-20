class SessionUser
  def initialize(session)
    @name = session[:name]
    @uid = session[:user_id]
    @token = session[:user_token]
    @secret = session[:user_secret]
  end

  attr_reader :name, :uid, :token, :secret
end