module LoginMacros
  def sign_in(user)
    visit root_path
    within("#login-form") do
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Login'
    end
  end

  def sign_out
    visit root_path
    click_link "(Logout)"
  end
end
