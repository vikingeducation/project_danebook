module ControllerTestHelpers

  def controller_sign_in(user)

    cookies[:auth_token] = user.auth_token

   current_user = user
  end

end