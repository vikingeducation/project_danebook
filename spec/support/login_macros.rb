module LoginMacros
  def log_in(user)
    within('.navbar-form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_button 'Sign in'
  end

  def log_out
    visit root_path
    click_link "Logout"
  end

  def sign_up(user)
    within '.new_user' do
      fill_in 'First Name', with: user.first_name
      fill_in 'Last Name', with: user.last_name
      fill_in 'Email', with: "fatcat@fatcat.com"
      fill_in 'Your New Password', with: user.user.password
      fill_in 'Confirm Your Password', with: user.user.password
      select('3', from: 'user[profile_attributes][birthdate(3i)]')
      select('May', from: 'user[profile_attributes][birthdate(2i)]')
      select('1980', from: 'user[profile_attributes][birthdate(1i)]')
      choose('Male')
    end
  end
end
