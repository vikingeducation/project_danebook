require 'rails_helper'

describe "ProfilesRequests" do

  let(:bob) { create(:user, profile: build(:profile)) }

  before do
    post login_path, params: { email: bob.email, password: bob.password }
  end

  describe "GET #show" do

    it "works correctly" do
      get user_profile_path(bob)
      expect(response).to be_success
    end

  end

  describe "GET #edit" do

    it "works correctly" do
      get edit_user_profile_path(bob)
      expect(response).to be_success
    end

  end

end