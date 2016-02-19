require 'rails_helper'


describe FriendingsController do 

  let(:friender) { create(:user) }
  let(:friend) { create(:user) }
  let(:friending) { create(:friending, friender_id: friender.id, friend_id: friend.id)}

  before :each do
    friender
    request.cookies[:auth_token] = friender.auth_token
    @request.env['HTTP_REFERER'] = root_path
  end


  describe "POST#create" do
    it "cannot friend someone more than once" do
      post :create, user_id: friender.id
      expect { post :create, user_id: friender.id }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "can add friend to friended_users" do
      expect { post :create, user_id: friender.id }.to change{friender.friended_users.count}.by(1)
    end

  end


  describe "DELETE#destroy" do

    it "removes friend but doesn't delete user" do
      friending
      delete :destroy, user_id: friender.id, id: friend.id
      
      friender.reload
      friend.reload
      expect(friender).to be_instance_of(User)
      expect(friend).to be_instance_of(User)
    end

  end

end