module UserMacros
  def sign_up(first_name="", last_name="")
    fill_in "First Name", with: first_name
    fill_in "Last Name", with: last_name
    fill_in "Your Email", with: "#{first_name}@#{last_name}.com"
    fill_in "Your New Password", with: "12345678"
    fill_in "Confirm Your Password", with: "12345678"
    choose('user_profile_attributes_gender_female')
  end

  def login(user)
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("Log in")
  end

  def wrong_login(user)
    fill_in "Email", with: user.email
    fill_in "Password", with: "#{user.password}foo!"
    click_button("Log in")
  end

  def edit_profile(text)
    fill_in "user_profile_attributes_words_to_live_by", with: text
    click_button("Save Changes")
  end
end