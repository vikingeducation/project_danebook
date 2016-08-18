require 'rails_helper'

describe SessionsController do

  let(:user){ create(:user) }

  describe "POST #create" do

    it "allows the creation of a new session" do
      post :create, params: { email: user.email, password: user.password }

      expect(cookies[:auth_token]).to_not be nil
    end

  end



end
