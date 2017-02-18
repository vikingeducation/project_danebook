require 'rails_helper'

describe "FriendingsRequests" do

  let(:bob) { create(:user) }
  let(:bill) { create(:user, :diff_user) }
  let(:profile) { build(:profile) }

  before do
    bob.profile = profile
    post login_path, params: { email: bob.email, password: bob.password }
  end

  describe "POST #create" do

    it "adds a friended user to current user's list of friends" do
      expect{
        post friendings_path, params: { id: bill.id }
      }.to change(Friending, :count).by(1)
    end

  end

  describe "DELETE #destroy" do

    before do
      bob.friended_users << bill
    end

    it "removes a friended user from current user's list of friends" do
      expect{
        delete friending_path(bill)
      }.to change(Friending, :count).by(-1)
    end

  end

end