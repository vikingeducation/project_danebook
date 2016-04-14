require 'rails_helper'


feature 'new users' do

  let(:user) { build(:user) }

  scenario 'valid sign up takes user to profile page' do
    visit root_path

    fill_in('First Name', with: 'John')
    fill_in('Last Name', with: 'Doe')
    fill_in('Your Email', with: 'john@doe.com')
    fill_in('Your New Password', with: 'password')
    fill_in('Confirm Your Password', with: 'password')
    click_on('Sign Up!')

    expect(page).to have_content('About')
    expect(page).to have_css('form.edit_profile')
  end


  scenario 'invalid credentials creates errors' do
    visit root_path
    click_on('Sign Up!')

    expect(page).to have_content('Error! User was not created')
    expect(page).to have_content('First Name is too short')
    expect(page).to have_content('Last Name is too short')
    expect(page).to have_content('Email is too short')
    expect(page).to have_content("Password can't be blank")
  end

end


feature 'existing users' do

  let(:user) { build(:user) }

  scenario "can log in with valid credentials" do
    user.save
    log_in(user)

    expect(page).to have_content("Success! You've successfully signed in")
    expect(page).to have_content(user.first_name)
    expect(page).to have_link("Log Out", logout_path)
  end


  scenario "cannot log in with invalid credentials" do
    visit root_path

    within('div.navbar-form') do
      fill_in("Email", with: "")
      fill_in("Password", with: "")
      click_on("Log In")
    end

    expect(page).to have_content("Error! Failed to sign in")
    expect(page).to have_content("Connect with all your friends!")
    expect(page).to have_button("Log In", login_path)
  end



end