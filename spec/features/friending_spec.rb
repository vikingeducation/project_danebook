require 'rails_helper'

feature "Friending" do

  let(:bob) { create(:user) }
  let(:profile) { build(:profile) }
  let(:diff_user) { create(:user, :diff_user) }

  before do
    bob.profile = profile
    diff_user.profile = profile
    visit root_path
    login(bob)
    visit user_path(diff_user.id)
  end

  context "friend" do
    it "allows a user to friend another user" do
      expect{click_on "I Want to be Friends with this Person!"}.to change(Friending, :count).by(1)
    end
  end

  context "unfriend" do
    it "allows a user to unfriend a friended user" do
      click_on "I Want to be Friends with this Person!"
      expect{ click_on "Unfriend" }.to change(Friending, :count).by(-1)
    end
  end

end