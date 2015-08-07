require 'rails_helper'

feature 'Sign up new user' do

  let(:user){ build(:user) }
  before do
    #goes to user profile, but shouldnt since not logged in
    visit root_path
  end

  context 'fill in the form fields with new user' do
    before do
      fill_in "First Name", with: user.first_name
      fill_in "Last Name", with: user.last_name
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
      choose('user_gender_0')
    end

    scenario 'should create a new user with all form fields filled' do
      expect{click_button "Sign Up"}.to change(User, :count).by(1)
      expect(page).to have_content("About")
      expect(page).to have_content("#{user.first_name}")
    end

    scenario 'should not create a new user with a missing form' do
      fill_in "Last Name", with: " "
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
      expect(page).to have_content("Sign Up")
      expect(page).to_not have_content("#{user.first_name}")
    end

    scenario 'should not create a new user with mismatched passwords' do
      fill_in "user_password_confirmation", with: "12345679"
      expect{click_button "Sign Up"}.to change(User, :count).by(0)
      expect(page).to have_content("Sign Up")
      expect(page).to_not have_content("#{user.first_name}")
    end

  end

end