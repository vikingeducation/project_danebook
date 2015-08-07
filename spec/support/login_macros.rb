module LoginMacros

  def sign_in(user)
    visit root_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button "Sign in"
  end

  def sign_out
    click_link "Logout"
  end

end