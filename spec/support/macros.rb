module Macros

  def fill_in_signup_forms(user)
    fill_in "firstName", with: user.first_name
    fill_in "lastName", with: user.last_name
    fill_in "inputEmail", with: user.email
    fill_in "Your Password", with: user.password
    fill_in "Confirm Password", with: user.password
    choose("Other")
  end

  def login(user)
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on("Log In")
  end

  def create_post(text)
    fill_in "post_body", with: text
    click_on "Post"
  end

  def create_comment(text)
    fill_in "comment_body", with: text
    click_on "Comment"
  end

end