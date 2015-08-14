module LoginMacros


  def fill_out_new_user_form(user_fields, profile_fields)
    fill_in 'user_profile_attributes_first_name', with: profile_fields.first_name
    fill_in 'user_profile_attributes_last_name', with: profile_fields.last_name

    fill_in 'user[email]', with: user_fields.email

    fill_in 'user[password]', with: user_fields.password
    fill_in 'user[password_confirmation]', with: user_fields.password

    select profile_fields.birthdate.strftime("%B"), from: 'user_profile_attributes_birthdate_2i'
    select profile_fields.birthdate.day, from: 'user_profile_attributes_birthdate_3i'
    select profile_fields.birthdate.year, from: 'user_profile_attributes_birthdate_1i'

    choose profile_fields.gender
  end


  def sign_in(user)
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"
  end


  def fill_out_user_profile(profile_fields)
    fill_in 'user_profile_attributes_college', with: profile_fields.college
    fill_in 'user_profile_attributes_hometown', with: profile_fields.hometown
    fill_in 'user_profile_attributes_currently_lives', with: profile_fields.currently_lives
    fill_in 'user_profile_attributes_telephone', with: profile_fields.telephone
    fill_in 'user_profile_attributes_words_to_live_by', with: profile_fields.words_to_live_by
    fill_in 'user_profile_attributes_description', with: profile_fields.description
  end

end