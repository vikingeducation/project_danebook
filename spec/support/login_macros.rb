module LoginMacros
  def sign_in(user)
    visit root_path
    find("#navbar").fill_in "Email", with: user.email
    find("#navbar").fill_in "Password", with: user.password
    click_button("Log In")
  end

  def sign_out
    visit root_path
    click_link("Logout")
  end
end