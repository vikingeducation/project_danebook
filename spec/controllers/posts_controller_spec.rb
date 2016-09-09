require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user){ create(:user) }
  before :each do
    sign_in(user)
  end
  describe "POST #create" do
    it "with valid params create a new post" do
      expect{
        post :create, post: attributes_for(:post, author: user)
      }.to change(Post, :count).by(1)
    end

    it "redirect_to timeline" do
      post :create, post: attributes_for(:post, author: user)
      expect(response).to redirect_to timeline_path(user)
    end
  end

  describe "DELETE #destroy" do
    # before :each do
    #   my_post = create(:post, author: user)
    # end
    let(:my_post){ create(:post, author: user) }
    it "can be destroyed" do
      my_post
      expect{
        process :destroy, :params => {:id => my_post.id}
      }.to change(Post, :count).by(-1)
    end
  end
end
