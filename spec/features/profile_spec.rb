require 'rails_helper'

feature "Edit Users" do

  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }

  before do
    profile
    visit root_path
  end

  context "as a not signed in user" do
    
    it "does not show edit link" do 
      visit "users/1"
      expect(page).to_not have_content("Edit your profile")
      expect(page).to_not have_content("Edit Profile")
    end

  end

  context "as a signed in user" do

    it "shows the edit link for the current user" do
      sign_in(user)
      expect(page).to have_content("Edit your profile")
      expect(page).to have_content("Edit Profile")
    end

    it "does not show the edit link for a different user" do
      another_user = create(:user, profile: build(:profile))
      sign_in(another_user)
      visit "1"
      expect(page).to_not have_content("Edit your profile")
      expect(page).to_not have_content("Edit Profile")
      expect(page).to have_content("Add Friend")
    end

    it "goes to edit page after clicking edit" do
      sign_in(user)
      click_link "Edit Profile"
      expect(page).to have_current_path(edit_user_path(user))
    end

    it "updates profile" do
      sign_in(user)
      visit edit_user_path(user)
      fill_in "user_email", with: "hello@bar.com"
      click_button "Save Changes"
      expect(current_path).to eq(user_path(user))
      expect(page).to have_content("hello@bar.com")
    end

    it "doesn't update profile if invalid inputs" do
      sign_in(user)
      visit edit_user_path(user)
      fill_in "user_email", with: ""
      click_button "Save Changes"
      expect(current_path).to eq(user_path(user))
    end
  end


end