require 'rails_helper'

feature 'Authentication', type: :feature do
  let(:new_user){ build(:user) }
  let(:existing_user){ create(:user) }
  before do
    visit root_path
  end

  context "A visitor" do
    scenario "'s root path is the sign-in page" do
      expect(page).to have_content('Sign In')
    end

    scenario "can create a new account" do
      find_link('Sign Up', match: :first).click
      expect(current_path).to eq(new_user_path)
      fill_in('Name', with: new_user.name)
      fill_in('Email', with: new_user.email)
      fill_in('Password', with: new_user.password)
      fill_in('Password Confirmation', with: new_user.password)
      click_button("Create Account")
      expect(page).to have_content(new_user.name)
    end

    scenario "is logged in after making a new account" do
      visit new_user_path
      fill_in('Name', with: new_user.name)
      fill_in('Email', with: new_user.email)
      fill_in('Password', with: new_user.password)
      fill_in('Password Confirmation', with: new_user.password)
      click_button("Create Account")
      expect(page).to have_content('Log Out')
    end

    scenario "can sign in to their existing account" do
      login(existing_user)
      expect(page).to have_content('Log Out')
    end
  end #visitor

  context "A signed-in user" do

    scenario "is redirected directed to their feed upon sign in" do
      login(existing_user)
      expect(current_path).to eq(user_feed_path(existing_user))
    end

    scenario "'s root path is their feed page" do
      login(existing_user)
      visit root_path
      expect(current_path).to eq(user_feed_path(existing_user))
    end

    scenario "can sign out" do
      login(existing_user)
      logout
      expect(current_path).to eq(root_path)
    end
  end #signed-in user

end #Authentication
