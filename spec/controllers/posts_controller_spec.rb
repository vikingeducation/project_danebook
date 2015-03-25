require 'rails_helper'

describe PostsController do
  let(:user){FactoryGirl.create(:user)}
  let(:user_post){FactoryGirl.create(:post)}

  context 'guest access' do

    describe 'GET #index' do
      it 'redirects to login' do
        expect(get :index, :user_id => user.id).to redirect_to(login_url)
      end
    end

    describe 'GET #show' do
      it 'redirects to login' do
        user.posts << user_post
        expect(get :show, {user_id: user.id, id: user_post.id}).to redirect_to(login_url)
      end
    end

    describe 'POST #create' do
      it 'redirects to login' do
        post :create, {user_id: user_post.user.id, post: FactoryGirl.attributes_for(:post)}
        expect(response).to redirect_to(login_url)
      end
    end

    describe 'PATCH #destroy' do
      it 'redirects to login' do
        expect(patch :destroy, user_id: user.id, id: user_post.id).to redirect_to(login_url)
      end
    end

  end


  context 'user logged in' do
    before(:each) do
      @current_user = FactoryGirl.create(:user)
      cookies[:auth_token] = @current_user.auth_token
      controller.current_user
    end


    describe 'GET #index' do
      it 'collects that users posts in descending date order' do
        posts = FactoryGirl.create_list(:post, 3, user_id: user.id)
        get :index, :user_id => user.id
        expect(assigns(:posts)).to eq posts.reverse
      end

      it 'collects that users friends' do
        3.times { user.friends << FactoryGirl.create(:user)}
        get :index, :user_id => user.id
        expect(assigns(:friends).sort).to eq user.friends.sort
      end
    end

    describe 'GET #show' do
      it 'does not show the post' do
        user.posts << user_post
        get :show, { user_id: user.id, id: user_post.id }
        expect(response).not_to render_template(:show)
      end

      context 'when user is current_user' do
        it 'redirects to the timeline' do
          controller.current_user.posts << user_post
          get :show, { user_id: controller.current_user.id, id: user_post.id }
          expect(response).to redirect_to user_timeline_path(controller.current_user)
        end
      end

      context 'when user is another user' do
        it 'redirects to root path' do
          user.posts << user_post
          get :show, { user_id: user.id, id: user_post.id }
          expect(response).to redirect_to root_path
        end
      end
    end

  end





end