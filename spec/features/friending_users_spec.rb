require 'rails_helper'

feature 'Friend/unfriend a user' do

  let(:user){create(:user)}
  let(:other_user){create(:user)}


  scenario 'redirects to sign in page when user not logged in' do
    visit user_posts_path(user.id)
    expect(page).to have_content("NOT AUTHORIZED, PLEASE SIGN IN!")
  end

  context 'friending a user' do

    before do
      sign_in(other_user)
      visit user_posts_path(user.id)
    end

    scenario "friend button shows on other user's Timeline" do
      expect(page).to have_content("Friend Me")
    end

    scenario "friend button shows on other user's About" do
      visit user_profile_path(user.id)
      expect(page).to have_content("Friend Me")
    end

    scenario "friend button does not show on user's own About" do
      visit user_profile_path(other_user.id)
      expect(page).to_not have_content("Friend Me")
    end

    scenario "button changes to unfriend after successful friending" do
      click_link "Friend Me"

      expect(page).to have_content("SUCCESS: YOU FRIENDED #{user.full_name.upcase}")
      expect(page).to have_content("Remove Friend")
    end

    context 'unfriending a user' do

      before do
        click_link "Friend Me"
        visit user_posts_path(user.id)
      end

      scenario "clicking 'Remove Friend' changes button to 'Friend Me'" do
        click_link "Remove Friend"
        expect(page).to have_content("SUCCESS: UNFRIENDED #{user.full_name.upcase}!")
        visit user_posts_path(user.id)
        expect(page).to have_content("Friend Me")
      end
    end


  end
end