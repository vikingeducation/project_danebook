require 'rails_helper'

describe "PostsRequests" do

  let(:bob) { create(:user) }
  let(:profile) {build(:profile)}
  let(:a_post) { build(:post) }

  before do
    bob.profile = profile
    post login_path, params: { email: bob.email, password: bob.password }
  end

  describe "POST #create" do

    context "valid params" do

      it "creates a new post" do
        expect{
          post posts_path, params: { post: attributes_for(:post) }
        }.to change(Post, :count).by(1)
      end

    end

    context "invalid params" do

      it "doesn't create a new comment on a post" do
        post posts_path, params: { post: attributes_for(:profile) }
        expect(response).not_to be_success
      end

    end

    it "creates a flash message" do
      post posts_path, params: { post: attributes_for(:post) }
      expect(flash[:success]).to_not be_nil
    end

  end

  describe "DELETE #destroy" do

    before do
      bob.authored_posts << a_post
    end

    it "deletes a post" do
      expect{
        delete post_path(a_post)
      }.to change(Post, :count).by(-1)
    end

  end

end