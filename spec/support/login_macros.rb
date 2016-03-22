module LoginMacros

  def sign_in(user)
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "Log In"
  end

  def bad_sign_in(user)
    fill_in "email", with: user.email
    fill_in "password", with: "wrongpassword"
    click_button "Log In"
  end

  def sign_out
    visit root_path
    click_link "Logout"
  end

  def sign_up(user)
    
    fill_in "user_first_name", with: user.first_name
    fill_in "user_last_name", with: user.last_name
    fill_in "user_email", with: "#{user.email}"
    fill_in "user_password", with: "#{user.password}"
    fill_in "user_password_confirmation", with: "#{user.password}"

    find("#user_profile_attributes_birthday_1i option[value='1997']").click
    find("#user_profile_attributes_birthday_2i option[value='1']").click
    find("#user_profile_attributes_birthday_3i option[value='1']").click

    choose("user_profile_attributes_gender_male")

    click_button("Sign Up!")
  end

  def bad_sign_up(user)
    
    fill_in "user_first_name", with: user.first_name
    fill_in "user_last_name", with: user.last_name
    fill_in "user_email", with: "#{user.email}"
    fill_in "user_password", with: "#{user.password}s"
    fill_in "user_password_confirmation", with: "#{user.password}"

    find("#user_profile_attributes_birthday_1i option[value='1997']").click
    find("#user_profile_attributes_birthday_2i option[value='1']").click
    find("#user_profile_attributes_birthday_3i option[value='1']").click

    choose("user_profile_attributes_gender_male")

    click_button("Sign Up!")
  end  

end
