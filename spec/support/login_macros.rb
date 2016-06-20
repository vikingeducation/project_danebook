module LoginMacros
  def sign_up_user(password_confirmation = nil)
    fill_in "user_profile_attributes_first_name", with: "john"
    fill_in "user_profile_attributes_last_name", with: "ong"
    fill_in "user_email", with: "john@vcs.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: ( password_confirmation.nil? ?
                                                      "password" : password_confirmation )
    select('February', from: "date_month")
    # select('18', from: 'date_day')
    # select('1990', from: 'user_profile_attributes_birth_year')
    choose "Male"
  end

  def sign_in(user)
    within(".navbar") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Come On!"
    end
  end
end