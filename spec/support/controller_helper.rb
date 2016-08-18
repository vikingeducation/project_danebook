module ControllerHelper

  def log_in(user)
    cookies.permanent[:auth_token] = user.auth_token
  end

  def log_out
    cookies.permanent[:auth_token] = ""
  end

end
