require 'rails_helper'

feature 'signing up' do
  before do
    visit root_path
  end

  scenario 'the root path should be the signup/signin screen' do
    expect(page).to have_css("#new_user")
  end

  context 'signing up with information' do
    scenario 'a user should be created if form is valid' do
      fill_in "user[first_name]", with: "Test"
      fill_in "user[last_name]", with: "Testy"
      fill_in "user[email]", with: "abc@foo.bar"
      fill_in "user[password]", with: "aaaaaaaa"
      fill_in "user[password_confirmation]", with: "aaaaaaaa"
      choose "user[gender]", option: 1
      expect{click_button "Sign Up"}.to change(User, :count).by(1)
    end

    scenario 'a user should not be created if form has mismatched passwords' do
      fill_in "user[first_name]", with: "Test"
      fill_in "user[last_name]", with: "Testy"
      fill_in "user[email]", with: "abc@foo.bar"
      fill_in "user[password]", with: "aaaaaaaa"
      fill_in "user[password_confirmation]", with: "aaaaaaab"
      choose "user[gender]", option: 1
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
    end

    scenario 'a user should not be created if form has too short a password' do
      fill_in "user[first_name]", with: "Test"
      fill_in "user[last_name]", with: "Testy"
      fill_in "user[email]", with: "abc@foo.bar"
      fill_in "user[password]", with: "aaaaaaa"
      fill_in "user[password_confirmation]", with: "aaaaaaa"
      choose "user[gender]", option: 1
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
    end

    scenario 'a user should not be created if form has invalid email' do
      fill_in "user[first_name]", with: "Test"
      fill_in "user[last_name]", with: "Testy"
      fill_in "user[email]", with: "abc@foo"
      fill_in "user[password]", with: "aaaaaaa"
      fill_in "user[password_confirmation]", with: "aaaaaaa"
      choose "user[gender]", option: 1
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
    end

    scenario 'a user should not be created if form has missing first name' do
      fill_in "user[first_name]", with: ""
      fill_in "user[last_name]", with: "Testy"
      fill_in "user[email]", with: "abc@foo.com"
      fill_in "user[password]", with: "aaaaaaa"
      fill_in "user[password_confirmation]", with: "aaaaaaa"
      choose "user[gender]", option: 1
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
    end

    scenario 'a user should not be created if form has missing last name' do
      fill_in "user[first_name]", with: "First"
      fill_in "user[last_name]", with: ""
      fill_in "user[email]", with: "abc@foo.com"
      fill_in "user[password]", with: "aaaaaaa"
      fill_in "user[password_confirmation]", with: "aaaaaaa"
      choose "user[gender]", option: 1
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
    end
  end
end
