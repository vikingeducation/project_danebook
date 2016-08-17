module SignUpMacros
  def sign_up(user)
    visit root_path
    within(".signup") do
      fill_in 'user_profile_attributes_first_name', with: user.profile.first_name
      fill_in 'user_profile_attributes_last_name', with: user.profile.last_name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      click_button 'Create User'
    end
  end
end
