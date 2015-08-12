require 'rails_helper'

describe FriendingsController do

  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  before do
    allow(request).to receive(:referer).and_return(user_path(user))
  end

  context 'logged in and current user' do

    before do
      allow(controller).to receive(:current_user) { user }
    end

    it 'should create a friending if user exists' do
      expect do
        post :create, user_id: friend.id
      end.to change(Friending, :count).by(1)
    end

    it 'should not create a friending if target does not exist' do
      expect do
        post :create, user_id: friend.id + 2
      end.to change(Friending, :count).by(0)
    end

    it "should also redirect to referrer if the user can't be found" do
      post :create, user_id: friend.id + 2
      expect(response).to redirect_to(user_path(user))
    end

    it 'should delete the friending' do
      create(:friending, friender: user, target: friend)
      expect do
        delete :destroy, user_id: friend.id
      end.to change(Friending, :count).by(-1)
    end

    specify 'cannot delete someone twice' do
      create(:friending, friender: user, target: friend)
      delete :destroy, user_id: friend.id
      expect do
        delete :destroy, user_id: friend.id
      end.to change(Friending, :count).by(0)
      expect(flash[:alert]).to eq("You already unfriended this person!")
    end

    it 'will warn the user if they attempt to friend a user twice' do
      post :create, user_id: friend.id
      post :create, user_id: friend.id
      expect(flash[:alert]).to eq("You're already friends with this person!")
    end

    specify 'and not create the friendship' do
      post :create, user_id: friend.id
      expect do
        post :create, user_id: friend.id
      end.to change(Friending, :count).by(0)
    end
  end

  context 'logged out user' do

    it 'should redirect the user' do
      post :create, user_id: 1
      expect(response.status).to eq(302)
      expect(response).to redirect_to(login_path)
    end

    it 'should not create a friending' do
      expect do
        post :create, user_id: friend.id
      end.to change(Friending, :count).by(0)
    end

    it 'should not delete the friending' do
      create(:friending, friender: user, target: friend)
      expect do
        delete :destroy, user_id: friend.id
      end.to change(Friending, :count).by(0)
    end
  end

end