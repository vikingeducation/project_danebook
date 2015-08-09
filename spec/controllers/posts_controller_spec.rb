require 'rails_helper'
require 'pry'

describe PostsController do
  let(:user){create(:user)}
  let(:tweet){create(:post)}
  before :each do
    session[:user_id] = user.id 
    tweet.author = user
  end

  describe "GET #index" do
    it "show timeline" do
      get :index, :user_id => user.id
      expect(response).to render_template :index
    end

  end

  describe "POST #create" do
    it "redirects to timeline" do
      post :create, :user_id => user.id, post: attributes_for(:post)
      expect(response).to redirect_to user_posts_path(:user_id => user.id)
    end

    it "creates a post" do     
      expect{post :create, :user_id => user.id, post: attributes_for(:post)}.to change(Post, :count).by(1)
    end
  end




end