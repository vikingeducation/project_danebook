module LogRequestMacros

  def login_as(user)
    post session_path, params: { :user => attributes_for(:user) }
  end

  def log_out
    delete session_path
  end


end
