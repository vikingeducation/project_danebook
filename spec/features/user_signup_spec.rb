require 'rails_helper'

feature 'sign up new user' do

  let(:user){ create(:user) }

  before do
    visit root_path
  end

  scenario 'should add a new user' do
    name = "tester"

    fill_in "user_first_name", with: name
    fill_in "user_last_name", with: "foobar"
    fill_in "user_email", with: "#{name}@test.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    select("January", :from => 'user_birthdate_2i')
    select("2", :from => 'user_birthdate_3i')
    select("2000", :from => 'user_birthdate_1i')
    choose("user_profile_attributes_gender_female")

    expect{click_button "Sign Up"}.to change(User, :count).by(1)

    expect(page).to have_content("Welcome, #{name}")

    expect(page).to have_content("Your account was successfully created!".upcase)
  end

  scenario 'Can not sign up as new user with and existing email' do
    fill_in "user_first_name", with: "testing"
    fill_in "user_last_name", with: "foobar"
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    select("January", :from => 'user_birthdate_2i')
    select("2", :from => 'user_birthdate_3i')
    select("2000", :from => 'user_birthdate_1i')
    choose("user_profile_attributes_gender_female")

    expect{click_button "Sign Up"}.to change(User, :count).by(0)

    expect(page).to have_content("ERROR: WE COULDN'T CREATE YOUR ACCOUNT.")
  end

end