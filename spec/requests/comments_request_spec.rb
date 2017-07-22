require 'rails_helper'

describe 'CommentsRequests' do

  let(:user){create(:user)}
  let(:profile){user.create_profile}

  before do
    user
    profile
  end

  describe "POST #create" do

    specify "creates a new user" do
      expect{ post users_path, params: { user: attributes_for(:user), profile: attributes_for(:profile) } }.to change(User, :count).by(1)
    end

    specify "sets an auth token coookie" do
      post users_path, params: { user: attributes_for(:user), profile: attributes_for(:profile) } }
      expect(response.cookies[:auth_token]).not_to be_nil
    end

  end
#........==========

# comments - create, delete


end
