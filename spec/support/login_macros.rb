module LoginMacros
  def fill_sign_up(user)
    within('.col-md-6 .new_user') do
      fill_in 'Username', with: user.username
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button('Sign Up')
    end
  end

  def fill_sign_in(user)
    within('#nav-bar') do
      fill_in 'Email:', with: user.email
      fill_in 'Password:', with: user.password
      click_button('Log in')
    end
  end
end