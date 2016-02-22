require 'rails_helper'

feature "User paths" do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }

  before do
    profile
    visit root_path
  end

  context "as a visitor" do

    scenario "sign up a new user" do
      new_user = build(:user)
      expect { sign_up(new_user) }.to change { User.count }.by(1)
      expect(page).to have_content("About: #{new_user.first_name}")
    end

    scenario "unable to sign up without invalid password confirmation" do
      new_user = build(:user)
      bad_sign_up(new_user)
      expect(page).to have_current_path users_path
      expect(page).to have_content("The sign up was not successful")
    end

  end

  context "as a not-signed in user" do

    scenario "sign in to account" do
      sign_in(user)
      expect(page).to have_content("About: #{user.first_name}")
    end

    scenario "not sign in to account" do 
      bad_sign_in(user)
      expect(page).to have_current_path root_path
      expect(page).to have_content("We couldn't sign you in")
    end

  end

  context "as a signed-in user" do

    scenario "sign out of account" do
      sign_in(user)
      click_link "Logout"
      expect(page).to have_content("You've successfully signed out")
      expect(page).to have_current_path root_path
    end

  end
end