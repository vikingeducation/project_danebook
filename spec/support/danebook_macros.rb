module DanebookMacros

  def sign_up_user_with_complete_default_attributes
    fill_in('user[profile_attributes][first_name]', with: 'Bobby')
    fill_in('user[profile_attributes][last_name]', with: 'Martin')
    fill_in('Your User Name', with: 'bobby')
    fill_in('Your Email', with: 'bobby@gmail.com')
    fill_in('Your Password', with: '12345678')
    fill_in('Confirm Password', with: '12345678')
    fill_in('user[profile_attributes][birthdate]', with: '10-10-2015')
    choose('user_profile_attributes_gender_male')
    click_button "Sign Up!"
    expect(current_path).to eq(edit_user_path(2))
  end  


  # def sign_in_deepa
  #   visit root_path
  #   click_link 'Login'
  #   fill_in 'Email', with: 'deepa@x.com'
  #   fill_in 'Password', with: 'foobar'
  #   click_button 'Log in'
  # end


  # def sign_in(user)
  #   visit root_path
  #   click_link 'Log In'
  #   fill_in 'Email', with: user.email
  #   fill_in 'Password', with: user.password
  #   click_button 'Log In'
  # end

  # def sign_out
  #   visit root_path
  #   click_link "Logout"
  # end
end
