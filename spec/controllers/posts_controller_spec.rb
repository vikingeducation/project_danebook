require 'rails_helper'
require 'pry'


describe PostsController do

  let(:user){create(:user)}

  context 'not logged in user' do

    it 'is redirected to sign in page when attempting to view timelines' do

      get :index, user_id: user.id
      expect(response).to redirect_to(login_path)
    end

  end


  context 'logged in user' do

    before :each do
      cookies[:auth_token] = user.auth_token
    end

    describe 'GET #index' do

      it "collects posts into @posts" do
        user.posts = create_list(:post, 5)
        user.save

        get :index, user_id: user.id

        expect(assigns(:posts)).to match_array user.posts
      end

      it "renders the :index template" do
        get :index, user_id: user.id

        expect(response).to render_template :index
      end
    end

    describe 'POST #create' do

      it 'can create a post with correct parameters' do
        expect do
          post :create, user_id: user.id,
                        post: attributes_for(:post)
        end.to change(Post, :count).by(1)
      end

      it 'redirects to index/refreshes' do
        post :create, user_id: user.id, post: attributes_for(:post)
        expect(response).to redirect_to (user_posts_path(user.id))
      end

      it "cannot create a post on another user's timeline" do
        another_user = create(:user)
        expect do
          post :create, user_id: another_user.id,
                        post: attributes_for(:post)
        end.to change(Post, :count).by(0)
      end

    end

    describe 'DELETE #destroy' do

      before :each do
        @post = create(:post, user: user)
      end

      it 'can destroy their own post' do
        expect do
          delete :destroy, user_id: user.id, id: @post
        end.to change(Post, :count).by(-1)
      end

      it "cannot destroy a post on another user's timeline" do
        another_user = create(:user)
        expect do
          delete :destroy, user_id: another_user.id, id: @post
        end.to change(Post, :count).by(0)
      end

    end

  end #end logged in context block
end