module UserFeatureHelpers

  def sign_in(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log In"
  end

  def sign_up(user)
    visit login_path
    fill_in "user_first_name", with: user.first_name
    fill_in "user_last_name", with: user.last_name
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
    select_an_option("January", "user_month")
    select_an_option("2", "user_day")
    select_an_option("1991", "user_year")
    choose "user_male"
    click_on "Sign Up!"
  end

  def select_an_option(value, id)
    page.select value, from: id
  end

  def create_post(user, post_content = "Welcome to the real world")
    visit user_activities_path(user)
    fill_in "post_content", with: post_content
  end

  def create_comment(content = "content")
    fill_in "comment_content", with: content
  end

end
