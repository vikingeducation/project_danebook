module LoginMacros
  def login(user)
    visit root_path

    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Sign in')
  end

  def fill_sign_up_info
    fill_in "user[first_name]", with: "El"
    fill_in "user[last_name]", with: "Duderino"
    fill_in "user[email]", with: "dude@abides.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    select "January", :from => "user[birth_date(2i)]"
    select "1", :from => "user[birth_date(3i)]"
    select "2001", :from => "user[birth_date(1i)]"
    choose "Female"
  end
end
