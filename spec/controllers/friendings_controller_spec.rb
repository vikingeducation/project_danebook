require 'rails_helper'

describe FriendingsController do

  let(:user){ create(:user) }
  let(:second_user){ create(:user) }

  before { log_in(user) }

  describe "POST #create" do

    it "adds a new friend to the current user" do
      expect do
        post :create, params: { user_id: second_user.id }
      end.to change(user.followees, :count).by(1)
    end

    it "does nothing without logged in user" do
      log_out

      expect do
        post :create, params: { user_id: second_user.id }
      end.to_not change(user.followees, :count)
    end

    it "sets a flash message on succesful creation" do
      post :create, params: { user_id: second_user.id }

      expect(flash[:notice]).to_not be_empty
    end

  end

  describe "DELETE #destroy" do

    before do
      user.followees << second_user
      user.save
    end

    it "removes a users friend" do
      expect do
        delete :destroy, params: { id: user.initiated_friendings.first.id }
      end.to change(user.followees, :count).by(-1)
    end

    it "does not change friendships if user does not exist" do
      expect do
        delete :destroy, params: { id: 1000 }
      end.to_not change(user.followees, :count)
    end

    it "sets a flash message upon success" do
      delete :destroy, params: { id: user.initiated_friendings.first.id }

      expect(flash[:alert]).to_not be_empty
    end

    it "sets a flash message upon failure" do
      delete :destroy, params: { id: 1000 }

      expect(flash[:alert]).to_not be_empty
    end

  end

end
