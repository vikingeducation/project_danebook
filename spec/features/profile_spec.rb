require 'rails_helper'

feature 'Profile' do
  let(:user) { create(:user) }

  before do
    visit login_path
  end

  context "logged in user has banner navigation tiles that" do
    before do
      sign_in(user)
    end

    scenario "allows user to view their own profile page" do
      click_link "About"
      expect(page).to have_css("#static_pages")
      expect(page).to have_content("Edit Profile")
      expect(page).to have_content("#{user.full_name}")
    end

    scenario "allows signed in users to view the edit page of their own profile" do
      click_link "About"
      click_link "Edit Profile"
      expect(page).to have_css("#static_pages")
      expect(page).to have_css(".edit_profile")
    end

  end

  context "logged in users can view profile edit page" do
    before do
      sign_in(user)
      click_link "About"
      click_link "Edit Profile"
    end

    scenario "allows signed in users to update profile" do
      edit_profile
      expect(page).to have_css("#static_pages")
      expect(page).to have_content("Edit Profile")
      expect(page).to have_content("#{user.full_name}")
    end
  end
end
