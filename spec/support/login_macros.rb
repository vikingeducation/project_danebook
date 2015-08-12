module LoginMacros
  def sign_in(user, options = {})
    visit login_path
    fill_in "example@email.com",  with: options[:email] || user.email
    fill_in "Password",        with: options[:password] || "password"
    check('remember_me') if options[:remember_me]
    click_button "Sign in"
  end

  def sign_out
    visit root_path
    click_on "Log out"
  end

  def search(options = {})
    fill_in "Search for Users", with: options[:terms] || ""
    click_button "Search"
  end

  def sign_up(options = {})
    fill_in "First Name", with: options[:first_name] || "Foo"
    fill_in "Last Name",  with: options[:last_name]  || "Bar"
    fill_in "Your Email", 
            with: options[:email]    || "foobar@email.com"
    fill_in "Your New Password", 
            with: options[:password] || "password"
    fill_in "Confirm Your Password", 
            with: options[:password_confirmation] || "password"
    select(options[:month]  || "Aug",   :from => 'user_birthday_2i') unless options[:month] == ""
    select(options[:day]    || '8',     :from => 'user_birthday_3i')unless options[:day] == ""
    select(options[:year]   || '1993',  :from => 'user_birthday_1i')unless options[:year] == ""
    choose("user_gender_#{options[:gender] || 'male'}") unless options[:gender] == ""
  end

  def delete_temporary_cookies
    Capybara.current_session.driver.browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar.instance_variable_get(:@cookies).reject! do |existing_cookie|
        existing_cookie.expired? != false
    end
  end
end