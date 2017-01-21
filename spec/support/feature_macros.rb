module FeatureMacros

  def sign_up_user(user, profile)

    visit('/')

    within("form#new_user") do

      fill_in 'First Name', with: user.first_name
      fill_in 'Last Name', with: user.last_name
      fill_in 'Your Email', with: user.email
      fill_in 'Your New Password', with: user.password
      fill_in 'Confirm Your Password', with: user.password_confirmation

      select profile.birth_month, from: 'Month'
      select profile.birth_day, from: 'Day'
      select profile.birth_year, from: 'Year'
      choose(profile.gender)

      click_on 'Create Account'

    end
  end

  def log_in_user(user)

    visit('/')

    within("nav") do

      fill_in 'email', with: user.email
      fill_in 'password', with: user.password

      click_on 'Enter the Danebook'

    end

  end

end