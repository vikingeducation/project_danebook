require 'rails_helper'

describe 'PostsRequests' do
  let(:user){ create(:profile).user}
  def create_post(user)
    post user_posts_path(user), params: {post: attributes_for(:post, user: user)}
  end
  describe 'GET #index' do
    it 'does not require login to show posts' do
      get user_profile_path(user)
      expect(response).to be_success
    end
  end
  describe 'POST #create' do
    context 'logged out' do
      it 'requires login' do
        create_post(user)
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
      end
      it 'creates a post' do
        expect{ create_post(user) }.to change(user.posts, :count).by(1)
      end
      it 'refreshes the page on post creation' do
        create_post(user)
        expect(response).to have_http_status(:redirect)
      end
      it 'does not allow posting on another person\'s timeline' do
        friend = create(:user)
        expect{ create_post(friend) }.not_to change(friend.posts, :count)
      end
    end
  end
  describe 'DELETE #destroy' do
    context 'logged out' do
      it 'does not destroy posts' do
        post = create(:post, user: user)
        expect{ delete user_post_path(user, post) }.not_to change(user.posts, :count)
        expect(flash[:error]).not_to be_nil
      end
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
      end
      it 'destroys own posts' do
        post = create(:post, user: user)
        expect{ delete user_post_path(user, post)}.to change(user.posts, :count).by(-1)
      end
      it 'does not destroy another\'s post' do
        friend = create(:user)
        post = create(:post, user: friend)
        expect{ delete user_post_path(user, post)}.not_to change(friend.posts, :count)
      end
    end
  end
end
