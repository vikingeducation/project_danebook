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

end