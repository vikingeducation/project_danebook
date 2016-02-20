require 'rails_helper.rb'

describe ProfilesController do

  describe "Logged In User" do

    let(:user) { create(:user) }
    let(:profile) { create(:profile, user: user) }
    let(:new_post) { create(:post, user: user) }
    let(:user_2) { create(:user) }
    let(:profile_2) { create(:profile, user: user_2) }
    let(:new_post_2) { create(:post, user: user_2)}

    before do
      user
      profile
      new_post
      user_2
      profile_2
      new_post_2
      create_session(user)
    end

    it "POST #create for current user" do
      # post :create, post: attributes_for(:post)
      # expect(response).to redirect_to user_path(user)
    end

    it "DELETE #destroy for current user's comment"
    it "DELETE #destroy for another user's comment"
  end

end
