module LoginMacros


  def sign_in(user)
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"
  end


  def sign_out
    click_link 'Log Out'
  end


  def fill_out_new_user_form(user)
    fill_in 'user_profile_attributes_first_name', with: user.profile.first_name
    fill_in 'user_profile_attributes_last_name', with: user.profile.last_name

    fill_in 'user[email]', with: user.email

    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password

    select user.profile.birthdate.strftime("%B"), from: 'user_profile_attributes_birthdate_2i'
    select user.profile.birthdate.day, from: 'user_profile_attributes_birthdate_3i'
    select user.profile.birthdate.year, from: 'user_profile_attributes_birthdate_1i'

    choose user.profile.gender
  end



  def fill_out_user_profile(profile_fields)
    fill_in 'profile_college', with: profile_fields.college
    fill_in 'profile_hometown', with: profile_fields.hometown
    fill_in 'profile_currently_lives', with: profile_fields.currently_lives
    fill_in 'profile_telephone', with: profile_fields.telephone
    fill_in 'profile_words_to_live_by', with: profile_fields.words_to_live_by
    fill_in 'profile_description', with: profile_fields.description
  end

end