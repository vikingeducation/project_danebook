require 'rails_helper'
require 'pry'

describe 'LikesRequests' do
  let(:user){ create(:profile).user }
  let(:posting){ create(:post)}
  let(:like){ create(:like, post: posting, user: user)}
  describe 'POST #create' do
    it 'must be logged in to like' do
      expect { post post_likes_path(posting)}.to change(posting, :likes_count).by(0)
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
      end
      it 'creates a like' do
        expect{ post post_likes_path(posting)}.to change(Like, :count ).by(1)
      end
    end
  end
  describe 'DELETE #destroy' do
    it 'must be logged in to destroy' do
      like
      expect{ delete post_like_path(posting, like) }.to change(Like, :count).by(0)
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
        like
      end
      it 'destroys like' do
        expect{ delete post_like_path(posting, like) }.to change(Like, :count).by(-1)
        expect{ posting.reload }.to change(posting, :likes_count).by(-1)
      end
    end
  end

end
