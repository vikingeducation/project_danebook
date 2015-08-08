module LoginMacros

  def sign_in(user)
    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  def sign_out(user)
    visit root_path
    click_link "Sign Out"
  end

end