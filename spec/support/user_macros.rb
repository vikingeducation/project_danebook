module UserMacros

  def sign_up(email)
    fill_in "user[email]", with: email
    fill_in "user[password]", with: "foobarfoobar"
    fill_in "user[password_confirmation]", with: "foobarfoobar"
  end

  def sign_in(user)
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log In'
  end

  def sign_out
    click_link "Logout"
  end




end