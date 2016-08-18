require 'rails_helper'

describe ProfilesController do 

  let(:user){ create(:user, :with_auth_token) }
  let(:profile){ create(:profile, user: user) }

  before do 
    profile
    cookies[:auth_token] = user.auth_token
  end

  describe "PATCH #update" do 

    describe "happy path" do 

      specify "the user's profile can be updated" do 
        patch :update, user_id: user.id, profile: { college: "zoo school" }
        profile.reload
        expect(profile.college).to eq("zoo school")
      end

      it "produces a flash upon update" do
        patch :update, user_id: user.id, profile: { college: "zoo school" }
        assert_equal flash[:success], "Your \"About\" page was updated."
      end

    end
    
  end

end