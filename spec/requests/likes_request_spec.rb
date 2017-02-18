require 'rails_helper'

describe "LikesRequests" do

  let(:bob) { create(:user, profile: build(:profile)) }
  let(:a_post) { create(:post, author: bob) }
  let(:a_like) { create(:like, liker: bob, likable_thing: a_post) }

  before do
    post login_path, params: { email: bob.email, password: bob.password }
  end

  describe "POST #create" do

    it "creates a like on a post" do
      a_post
      expect{
        post post_likes_path(a_post), headers: { "HTTP_REFERER" => root_url }
      }.to change(Like, :count).by(1)
    end

  end

  describe "DELETE #destroy" do

    it "deletes a like on a post" do
      a_like
      expect{
        delete post_like_path(a_post, a_like), headers: { "HTTP_REFERER" => root_url }
      }.to change(Like, :count).by(-1)
    end

  end

end