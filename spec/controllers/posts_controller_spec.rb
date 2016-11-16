require 'rails_helper'

describe PostsController do
  let(:user){ create(:user) }

  before do
    request.cookies["auth_token"] = user.auth_token
  end

  describe 'GET #index' do
    it "goes to index if on someone else's page" do
      another_user = create(:user)
      get :index, :user_id => another_user.id
      expect(response).to render_template :index
    end

    it "goes to new if on your own page" do
      get :index, :user_id => user.id
      expect(response).to redirect_to new_user_post_path(user)
    end
  end

  describe 'POST #create' do
    it "creates a new post" do
      expect{ post :create, :user_id => user.id, :post => attributes_for(:post) }.to change(Post, :count).by(1)
    end

    it "redirects to the user's timeline" do
      post :create, :user_id => user.id, :post => attributes_for(:post)
      expect(response).to redirect_to new_user_post_path(user)
    end

    it "renders new for an empty body" do
      post :create, :user_id => user.id, :post => attributes_for(:post, body:"")
      expect(response).to render_template :new
    end
  end

  describe "DELETE #destroy" do

    let(:new_post){ create(:post, user:user) } 
    before do
      new_post
    end

    it "deletes the post" do
      expect{ delete :destroy, :user_id => user, :id => new_post.id }.to change(Post, :count).by(-1)
    end

    it "redirects to timeline" do
      delete :destroy, :user_id => user, :id => new_post.id
      expect(response).to redirect_to new_user_post_path(user)
    end
  end

end