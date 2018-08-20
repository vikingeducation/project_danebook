require 'rails_helper'

describe 'PostsRequests' do

  describe 'User Access' do

    let(:user){ create(:user) }
    let(:profile){ create(:profile, user_id: user.id) }
    let(:posts){ create_list(:post, 5, user_id: user.id) }

    before :each do
      post session_path, params: { email: user.email, password: user.password }
      user
      profile
      posts
    end

    describe 'get #index' do
      it 'works as normal' do
        get user_timeline_path(user)
        expect(response).to be_success
      end
    end

    describe 'get #new' do
      it 'works as normal' do
        get new_user_post_path(user), params: { post: attributes_for(:post) }
        expect(response).to be_success
      end

    end

    describe 'post #create' do
      it 'actually creates a new post' do
        expect{ post user_posts_path(user),
                params: { post: attributes_for(:post) }}
                .to change(user.posts, :count).by(1)
      end
      it 'creates a flash message' do
        post user_posts_path(user), params: { post: attributes_for(:post) }
        expect(flash[:success]).not_to be_nil 
      end

      it 'redirects if successful'
    end

    describe 'delete #destroy' do
    end

  end

  describe 'Non-User Access' do
  end

end
