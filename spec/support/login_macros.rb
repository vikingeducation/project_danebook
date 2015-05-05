module LoginMacros

  def sign_in(user)
    visit root_path
    fill_in first('Email'), with: user.email
    fill_in first('Password'), with: user.password
    click_button 'Log In'
  end

end