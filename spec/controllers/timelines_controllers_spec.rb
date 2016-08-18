require 'rails_helper'

describe TimelinesController do
  let(:profile) {create(:profile)}
  let(:user){ create(:user, :profile => profile )}

  before do
    login(user)  
  end
 
  describe "GET #show" do

    it "gets the right user's timeline" do
      get :show, params: {user_id: user.id}
      expect(response.status).to eq(200)
    end 

  end

end