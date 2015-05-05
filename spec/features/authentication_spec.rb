

# This feature spec not asked for by the assignment, but nice to have anyway!
require 'rails_helper'

feature 'Authentication' do
  let(:user){ FactoryGirl.create(:user) }
  before do
    visit root_path
  end

  context "with improper credentials" do
    before do
      user.email = user.email + "x"
      sign_in(user)
    end

    scenario "does not allow sign in" do
      expect(page).to have_content "Something went wrong with your signin."
    end
  end

  context "with proper credentials" do
    before do
      sign_in(user)
    end
    scenario "successfully signs in an existing user" do
      # verify we're on the user's show page now
      expect(page).to have_content "You're signed in"
    end

    context "after signing out" do
      before do
        sign_out
      end
      scenario "signs out the user" do
        expect(page).to have_content "You've successfully signed out"
      end
    end
  end
end
