module LoginMacros
  def sign_in(user)
    visit root_path
    fill_in 'emailInput1', with: user.email
    fill_in 'password', with: "foobar"
    click_button 'Sign in'
  end

  def set_user(user)
    @user = user
  end
end