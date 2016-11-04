module AuthMacros
  def login(user)
    visit login_path
    fill_in('email', with: user.email)
    fill_in('password', with: 'password')
    click_button('Log in')
  end

  def login_user
    request.cookies[:auth_token] = user.auth_token
  end
end
