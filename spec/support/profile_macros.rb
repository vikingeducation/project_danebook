module ProfileMacros
  def fill_about_form(profile)
    fill_in 'profile_first_name', with: profile.first_name
    fill_in 'profile_last_name', with: profile.last_name
    fill_in 'profile_about', with: profile.about
    select profile.birthday.strftime("%-d"), from: 'profile_birthday_3i'
    select profile.birthday.strftime("%B"), from: 'profile_birthday_2i'
    select profile.birthday.strftime("%Y"), from: 'profile_birthday_1i'
    click_button 'Update'
  end
end
