module UserAuth

  def sign_me_in(user)
    request.cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  def sign_me_out
    @current_user = nil
    request.cookies.delete(:auth_token)
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
end