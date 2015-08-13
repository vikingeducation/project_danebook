require 'rails_helper'

feature 'Log in User' do

  let(:user){ create(:user) }
  before do
    visit new_user_path
  end

  context "with improper credentials" do
    before do
      user.email = user.email + "x"
      sign_in(user)
    end
    
    scenario "does not allow sign in" do
      expect(page).to have_content "We couldn't sign you in"
    end

  end

  context "with proper credentials" do
    before do
      sign_in(user)
    end

    scenario "sucessfully signs in an existing user" do
      expect(page).to have_content "You've successfully signed in"
      expect(page).to have_content "#{user.first_name}"
      expect(page).to have_content "About"
    end
  end

end