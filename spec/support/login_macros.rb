module LoginMacros
  def sign_in(user)
    visit login_path
    within(".navbar-form") do
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
    end
    click_button 'Log in'
  end

  def sign_up(user_attrs)
    visit login_path
    within(".new_user") do
      # binding.pry
      fill_in 'user[first_name]', with: user_attrs[:first_name]
      fill_in 'user[last_name]', with: user_attrs[:last_name]
      fill_in 'user[email]', with: user_attrs[:email]
      fill_in 'user[password]', with: user_attrs[:password]
      fill_in 'user[password_confirmation]', with: user_attrs[:password]
    end
    click_button 'Sign Up!'
  end

  def sign_out
    visit root_path
    click_link "logout"
  end
end
