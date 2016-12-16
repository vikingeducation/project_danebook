module UserMacros

  def sign_up(valid_attributes)
    process :create, params: { user: valid_attributes }
  end

  def log_in(user)
    cookies[:auth_token] = user.auth_token
  end

  def update_user(user, profile, new_city)
    process :update, params: { id: user.id, user: attributes_for(:user, profile_attributes: attributes_for(:profile, hometown: new_city)) }
  end

end