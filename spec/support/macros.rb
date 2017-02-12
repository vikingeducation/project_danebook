module Macros

  def fill_in_signup_forms(user)
    fill_in "firstName", with: user.first_name
    fill_in "lastName", with: user.last_name
    fill_in "inputEmail", with: user.email
    fill_in "Your Password", with: user.password
    fill_in "Confirm Password", with: user.password
    choose("Other")
  end

end