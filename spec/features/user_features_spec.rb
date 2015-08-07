require 'rails_helper'


feature 'Sign Up' do

  let(:user){build(:user)}
  before do
    visit root_path
  end


  # Happy
  scenario 'User should be able to sign up' do

    within('section#sign-up-form') do
      fill_in "First Name",  with: user.first_name
      fill_in "Last Name",  with: user.last_name
      fill_in "Email", with: user.email
      fill_in "Password",  with: user.password
      fill_in "Confirm Password",  with: user.password_confirmation
    end

    expect{click_button "Sign-Up"}.to change(User, :count).by(1)
  end

  # Sad
  scenario 'User should not be able to sign up without matching passwords' do

    within('section#sign-up-form') do
    fill_in "First Name",  with: user.first_name
      fill_in "Last Name",  with: user.last_name
      fill_in "Email", with: user.email
      fill_in "Password",  with: "password"
      fill_in "Confirm Password",  with: "passw0rd"
    end
    expect{click_button "Sign-Up"}.to change(User, :count).by(0)
  end

  scenario 'User should not be able to sign up with duplicate emails' do

    within('section#sign-up-form') do
      user.save
    fill_in "First Name",  with: user.first_name
      fill_in "Last Name",  with: user.last_name
      fill_in "Email", with: user.email
      fill_in "Password",  with: "password"
      fill_in "Confirm Password",  with: "passw0rd"
    end
    expect{click_button "Sign-Up"}.to change(User, :count).by(0)
  end

end

feature 'Sign In' do

  let(:user){build(:user)}
  before do
    visit root_path
  end


  # Happy
  scenario 'User should be able to sign up' do
    user.save
    within('nav') do
      fill_in "Email", with: user.email
      fill_in "Password",  with: user.password
      click_button "Sign In"
    end

    expect(page).to have_content user.first_name
  end

  scenario 'User should be able to sign up' do
    user.save
    within('nav') do
      fill_in "Email", with: user.email
      fill_in "Password",  with: "ssdf"
      click_button "Sign In"
    end

    expect(page).not_to have_content user.first_name
  end
  # Sad


end