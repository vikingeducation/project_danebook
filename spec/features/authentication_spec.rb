require 'rails_helper'

feature 'Authentication' do
  let(:user) { create(:user) }

  before do
    visit login_path
  end

  context 'with improper credentials' do
    before do
      user.email = user.email + "x"
      sign_in(user)
    end

    scenario "does not allow sign in" do
      expect(page).to have_content "Connect with all your friends!"
    end
  end

  context "with proper credentials" do
    before do
      sign_in(user)
    end

    scenario "allows sign in" do
      expect(page).to have_content "#{user.first_name} #{user.last_name}"
      expect(page).to have_content "logout"
    end
  end

  context "sign up with proper credentials" do
    let(:attrs){ attributes_for(:user) }

    scenario "allows creation of new user and corresponding profile" do
      sign_up(attrs)
      expect(page).to have_css "#static_pages"
      expect(page).to have_content "logout"
    end
  end

  context "signing out from any static page" do
    before do
      sign_in(user)
    end

    scenario "logs out the current user and returns to the login page" do
      click_link "logout"
      expect(page).to have_css "#login"
      expect(page).to have_content "Sign Up"
    end
  end
end
