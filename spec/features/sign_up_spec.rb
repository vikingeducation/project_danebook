require 'rails_helper'

feature "Signing up" do

  let(:bob) { build(:user) }
  let(:squidward) { build(:user, :squidward) }

  before do
    visit root_path
    fill_in_signup_forms(bob)
  end

  context "sign up" do

    scenario "sign up a new valid user" do
      expect{ click_on("Sign Up!") }.to change(User, :count).by(1)
      expect(page).to have_content "Edit Profile"
      click_link "About"
      expect(page).to have_content "Bob Dobbs"
      expect(page).to have_content "bob@subgenius.org"
    end

    scenario "disallow a new user from using an existing email" do
      click_on("Sign Up!")
      click_on("Logout")
      fill_in_signup_forms(squidward)
      expect{ click_on("Sign Up!") }.to change(User, :count).by(0)
      expect(page).to have_content "Oops!"
    end

    scenario "disallow a logged-in user from creating an additional account" do
      click_on("Sign Up!")
      visit(new_user_path)
      expect(page).to have_content "Logout"
    end

  end

  context "quit" do

    before do
      click_on("Sign Up!")
    end

    scenario "allow a user to delete his/her account, redirecting to the sign up page" do
      expect { click_on("Delete Account") }.to change(User, :count).by(-1)
    end

    scenario "don't log in a deleted user to his/her deleted account" do
      click_on("Delete Account")
      login(bob)
      expect(page).not_to have_content("Logout")
    end

  end

end