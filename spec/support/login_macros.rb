module LoginMacros
  def log_in(user)
    visit root_path

    within('div.navbar-form') do
      fill_in("Email", with: user.email)
      fill_in("Password", with: user.password)
      click_on("Log In")
    end
  end

  def log_out
    click_link "Log Out"
  end
end