require 'rails_helper'

feature 'signing up' do
  before do
    visit root_path
  end

  scenario 'the root path should be the signup/signin screen' do
    expect(page).to have_css("form#new_user")
  end

  context 'signing up with information' do
    scenario 'a user should be created if form is valid' do
      fill_out_signup_form
      expect{click_button "Sign Up"}.to change(User, :count).by(1)
    end

    scenario 'a user should not be created if form has mismatched passwords' do
      fill_out_signup_form(password_confirmation: 'aaaaaaab')
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
    end

    scenario 'a user should not be created if form has too short a password' do
      fill_out_signup_form(password: 'aaaaaaa', password_confirmation: 'aaaaaaa')
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
    end

    scenario 'a user should not be created if form has invalid email' do
      fill_out_signup_form(email: 'foo@bar')
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
    end

    scenario 'a user should not be created if form has missing first name' do
      fill_out_signup_form(first_name: "")
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
    end

    scenario 'a user should not be created if form has missing last name' do
      fill_out_signup_form(last_name: "")
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
    end

    scenario 'a user should not be able to input an age too young' do
      expect{select 11.years.ago.year.to_s, from: 'user_dob_1i'}.to raise_error(Capybara::ElementNotFound)
    end
  end
end
