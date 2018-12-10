require 'rails_helper'

RSpec.feature 'NonUserInteractions' do

  feature 'Not a User' do

    let(:user) {create(:user, user_id: 1)}

    scenario "I would like to sign up to be a user" do
      visit root_path
      fill_in "First Name", with: "Nob"
      fill_in "Last Name", with: "Nurger"
      fill_in "user_email", with: "nob@nurgers.com"
      fill_in "user_password", with: "123456"
      fill_in "user_password_confirmation", with: "123456"
      fill_in "user_profile_attributes_birthday", with: "12/12/1958"
      choose "user_profile_attributes_gender_male"
      expect{click_button "Sign Up!"}.to change{ User.count }.by(1)
      expect(page).to have_content "Created New User Successfully!"
      expect(page).to have_content "Nob Nurger"
    end

    scenario "I could try to see a user's timeline" do
      visit root_path
      visit '/users/1'
      expect(page).to have_content "Not Authorized, please sign in!"
      expect(page).to have_content "Sign up"
      expect(current_path).to eq(root_path)
    end

    scenario "I could try to see a user's profile" do
      visit root_path
      visit '/users/1/profile'
      expect(page).to have_content "Not Authorized, please sign in!"
      expect(page).to have_content "Sign up"
      expect(current_path).to eq(root_path)
    end
  end

end
