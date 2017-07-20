module LogRequestMacros

  def login_as(user)
    post session_path, params: { email: user.email, password: user.password }
  end

  def log_out
    delete session_path
  end


end
