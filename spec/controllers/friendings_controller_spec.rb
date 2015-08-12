require 'rails_helper'

RSpec.describe FriendingsController, type: :controller do

  let(:friender){create(:user)}
  let(:friendee){create(:user)}
  before do
    allow(controller).to receive(:current_user).and_return(friender)
    current_user = friender
  end

  describe "#create" do
    it "returns http redirect" do
      current_user
      post :create, {id: friendee.id}
      expect(response).to have_http_status(:redirect)
    end

    it "should add friendee to friended_users" do
      friender
      post :create, {id: friendee.id}
      expect(friender.friended_users.count).to eql(1) 
    end

  end

  describe "#destroy" do
    xit "returns http redirect" do
      delete :destroy, id: 1
      expect(response).to have_http_status(:redirect)
    end
  end

end
