require 'rails_helper'

describe PostsController do

  describe 'Users can create posts' do
    let(:user) { create(:user) }
    describe 'posts/create' do
      context 'with valid attributes' do
        before do
          login_user
          post :create, params: { post: attributes_for(:post) }
        end

        it 'redirects to users timeline page' do
          expect(response).to redirect_to timeline_path
        end

        it 'flashes success' do
          expect(flash[:success]).to_not be_nil
        end
      end

      context 'but without valid attributes' do
        before do
          login_user
          post :create, params: { post: attributes_for(:post, post_text: '') }
        end

        it 'they are redirected to timeline path' do
          expect(response).to redirect_to timeline_path
        end

        it 'there is no flash success' do
          expect(flash[:success]).to be_nil
        end
      end
    end
  end

  describe 'users can see all of someones posts' do
    let(:user) { create(:user) }
    let(:posts) { create_list(:post, 5, user: user) }

    before do
      posts
      login_user
    end

    describe 'posts/index' do
      context 'with user id specified' do
        before do
          get :index, params: { id: user.id }
        end

        it 'assigns specified users posts to posts instance variable' do
          expect(assigns(:posts)).to match_array(user.posts)
        end

        it 'assigns new post instance to post instance variable' do
          expect(assigns(:post)).to be_instance_of(Post)
        end

        it 'renders the timeline page' do
          expect(response).to render_template 'static_pages/timeline'
        end
      end

      context 'without user id specified' do
        before do
          login_user
          get :index
        end

        it 'assigns current users posts to posts instance variable' do
          expect(assigns(:posts)).to match_array(user.posts)
        end
      end
    end
  end

  describe 'users can destroy their posts' do
    let(:user) { create(:user) }
    let(:a_post) { create(:post, user: user) }
    describe 'posts#destroy' do
      context 'user is signed in and destroying their own post' do
        before do
          a_post
          login_user
        end

        it 'destroys the specified post' do
          expect do
            post :destroy, params: { id: a_post.id }
          end.to change(Post, :count).by(-1)
        end

        it 'flashes success' do
          post :destroy, params: { id: a_post.id } # is it a bad idea to post to an action from the before block?
          expect(flash[:success]).to_not be_nil
        end
      end

      context "user is signed in and destroying someone else's post" do
        let(:otheruser) { create(:user) }
        let(:a_post) { create(:post, user: otheruser) }

        before do
          login_user
        end

        it 'does not destroy the specified post' do
          change(Post, :count).by(0)
        end

        it 'does not flash success' do
          expect(flash[:success]).to be_nil
        end
      end

      context "user is not signed in" do
        it 'redirects the user to the login page' do
          post :destroy, params: { id: a_post.id }
          expect(request).to redirect_to login_path
        end

        it 'flashes an error' do
          post :destroy, params: { id: a_post.id }
          expect(flash[:error]).to_not be_nil
        end
      end
    end
  end
end
