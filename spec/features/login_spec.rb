require 'rails_helper'

feature "Logging" do

  let(:bob) { create(:user) }
  let(:profile) { build(:profile) }
  let(:bill) { build(:user, :diff_user) }

  before do
    bob.profile = profile
    visit root_path
  end

  context "log in" do

    it "logs an existing user in with the correct password" do
      login(bob)
      expect(page).to have_content "Logout"
    end

    it "does not log a new visitor in before signup" do
      login(bill)
      expect(page).not_to have_content "Logout"
    end

  end

  context "log out" do

    before do
      login(bob)
    end

    it "logs an existing user out" do
      click_on "Logout"
      expect(page).not_to have_content "Logout"
    end

  end

end