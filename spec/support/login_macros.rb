module LoginMacros
  def sign_in(user)
    visit root_path
    within "#login-dp" do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log In'
    end
  end

  def sign_out
    visit logout_path
  end
end
