module SigninMacros

  # Fills out the form with passing values. Override values by passing
  # them in as arguments in the format fill_out_signup_form(arg1: val1, arg2: val2)
  def login_user(**args)
    user = args[:previous_user] || create(:user)
    fill_in 'email', with: args[:email] || user.email
    fill_in 'password', with: args[:password] || user.password
    find(:css, "#remember_me[value='1']").set(args[:remember_me] || false)
    click_button 'Log In'
    return user
  end

  # Put together after reading the source of 'show_me_the_cookies' gem.
  # Requires rack_test driver for capybara.
  # This should be rewritten with 'show me the cookies' gem if needed to support
  # multiple drivers
  def delete_temporary_cookies
    Capybara.current_session.driver.browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar.instance_variable_get(:@cookies).reject! do |existing_cookie|
      existing_cookie.expired? != false
    end
  end
end
