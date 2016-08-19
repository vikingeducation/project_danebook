require 'rails_helper'

describe FriendshipsController do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  context "Logged In" do
    before do
      cookies["auth_token"] = user.auth_token
    end

    describe "POST #create" do
      it "let's users friend" do
        expect {
          post :create, params: { user_id: user2.id }
        }.to change(Friendship, :count).by(2)
      end
    end

    describe "DELETE #destroy" do


      it "is able to delete friendships when there's too much drama and I just can't anymore" do
        expect {
          delete :destroy, params: { id: user2.id }
        }.to change(Friendship, :count).by(-2)
      end
    end
  end

end
