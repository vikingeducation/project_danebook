require 'rails_helper'

describe FriendingsController do

  let(:friender) { create(:friender) }
  let(:user) { create(:user) }

  before :each do
    cookies[:auth_token] = friender.auth_token
  end

  describe "POST #create" do

    it "creates a friendship" do
      expect { post :create, user_id: user.id }.to change { Friending.count }.by(1)
    end

    it "redirects to newly friended profile" do
      post :create, user_id: user.id
      expect(response).to redirect_to user
    end

  end


  describe "DELETE #destroy" do

    before do
      friender.friended_users << user
    end

    it "destroys a friendship" do
      expect { delete :destroy, user_id: friender.id, id: user.id }.to change { friender.friended_users.count }.by(-1)
    end

    it "redirects to unfriended profile" do
      delete :destroy, user_id: friender.id, id: user.id
      expect(response).to redirect_to user
    end
  end

end