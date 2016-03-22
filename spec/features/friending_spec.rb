require 'rails_helper'

feature 'friending users' do

  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }

  before do
    profile
    visit root_path
  end

  context "not signed in" do
   
    scenario "doesn't show add friend button" do
      visit user_path(user)
      expect(page).to_not have_content("Add Friend")
    end

  end

  context "signed in user" do

    scenario "doesn't show add friend for current user page" do
      sign_in(user)
      expect(page).to_not have_content("Add Friend")
    end

    scenario "does show add friend for a different user page" do
      another_user = create(:user, profile: build(:profile))
      visit_(another_user)
      expect(page).to have_content("Add Friend")
    end

    scenario "adds friend to current user's friended user" do
      another_user = create(:user, profile: build(:profile))
      visit_(another_user)
      expect { click_link "Add Friend" }.to change { user.friended_users.count }.by(1)
    end

    scenario "redirects back to friend's profile" do
      another_user = create(:user, profile: build(:profile))
      visit_(another_user)
      click_link "Add Friend"
      expect(current_path).to eq(user_path(another_user))
    end

    scenario "changes add friend button to unfriend" do
      another_user = create(:user, profile: build(:profile))
      visit_(another_user)
      click_link "Add Friend"
      expect(page).to have_content("Unfriend")
    end

    scenario "unfriends a friend" do
      another_user = create(:user, profile: build(:profile))
      visit_(another_user)
      click_link "Add Friend"
      expect { click_link "Unfriend" }.to change { user.friended_users.count }.by(-1)
    end
  end
end