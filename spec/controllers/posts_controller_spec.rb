require 'rails_helper'

describe PostsController do
  let(:new_post) {build(:post)}
  let(:profile) {new_post.profile}
  let(:user) {profile.user}
  before { controller_sign_in(user) }

  context 'create' do

    it "should create a post" do
      expect { post :create, post: {body: new_post.body}
      }.to change(Post, :count).by(1)
      
    end

    xit "should redirect to timeline path" do
      post :create, post: {body: new_post.body}
      expect(response).to redirect_to profile_timeline_path(new_post.profile)
    end



  end

end