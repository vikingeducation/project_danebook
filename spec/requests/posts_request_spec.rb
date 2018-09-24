require 'rails_helper'

describe 'PostsRequests' do

  describe 'User Access' do

    let(:user){ create(:user) }
    let(:profile){ create(:profile, user_id: user.id) }
    let(:posts){ create_list(:post, 5, user_id: user.id) }
    let(:new_post){ create(:post, user_id: user.id) }

    before :each do
      post session_path, params: { email: user.email, password: user.password }
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

      it 'redirects if successful' do
        post user_posts_path(user), params: { post: attributes_for(:post) }
        expect(response).to redirect_to user_timeline_path(user)
      end

    end

    describe 'delete #destroy' do

      before do
        user
        new_post
      end

      it 'actually deletes post' do
        expect { delete user_post_path(user, new_post) }.to change(user.posts, :count).by(-1)
      end

      it 'redirects when successful' do
        delete user_post_path(user, new_post)
        expect(response).to redirect_to user_timeline_path(user)
      end

      it 'creates flash message' do
        delete user_post_path(user, new_post)
        expect(flash[:success]).not_to be_nil
      end

    end

  end
  
end
