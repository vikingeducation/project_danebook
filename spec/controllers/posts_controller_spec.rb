require 'rails_helper.rb'

describe PostsController do

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
      post :create, post: attributes_for(:post, user: user)
      expect(response).to redirect_to user_path(user)
      expect(flash[:success]).to eq "You've created a post!"
    end

    it "POST #create fails" do
      post :create, post: attributes_for(:post, body: nil)
      expect(response).to render_template "users/show"
      expect(flash[:danger]).to eq "Failed to create a post!"
    end

    it "DELETE #destroy for current user's comment" do
      delete :destroy, id: new_post.id
      expect(response).to redirect_to user_path(user)
      expect(flash[:success]).to eq "You've deleted a post!"
    end

    it "DELETE #destroy for another user's comment" do
      delete :destroy, id: 0
      expect(response).to redirect_to user_path(user)
    end
  end

end
