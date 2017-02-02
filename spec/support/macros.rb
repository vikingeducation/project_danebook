module Macros

  def sign_in(user)
    fill_in :email, with: "#{user.email}"
    fill_in :password, with: "#{user.password}"
    click_button('Log In')
  end

  def sign_up(user)
    fill_in 'First Name', with: "#{user.first_name}"
    fill_in 'Last Name', with: "#{user.last_name}"
    fill_in 'Your Email', with: "#{user.email}"
    fill_in 'Your New Password', with: "#{user.password}"
    fill_in 'Confirm Your Password', with: "#{user.password}"
    select("#{user.birth_month}", :from => 'user[birth_month]')
    select("#{user.birth_date}", :from => 'user[birth_date]')
    select("#{user.birth_year}", :from => 'user[birth_year]')
    choose('user_gender_true')
    click_button('Sign Up!')
  end

end