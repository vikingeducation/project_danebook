require 'rails_helper'

describe Post do
  let(:post){ create(:post)}
  let(:user){ create(:user)}
  context 'validations' do
    it 'is valid with body and user' do
      expect(post).to be_valid
    end
    it 'is invalid without body' do
      post.body = nil
      expect(post).to be_invalid
    end
    it 'is invalid without user' do
      post.user = nil
      expect(post).to be_invalid
    end
  end
  context 'associations' do
    it 'responds to likes' do
      expect(post).to respond_to(:likes)
    end
    it 'responds to comments' do
      expect(post).to respond_to(:comments)
    end
  end
  context '#liked_by?' do
    it 'correctly tells us if post is liked by a user' do
      post.likers << user
      expect(post.liked_by?(user)).to eq(true)
      expect(post.liked_by?(create(:user))).to eq(false)
    end
  end
  context 'class methods' do
    describe 'newsfeed_posts' do
      let(:user){ create(:user, :with_friends)}
      before do
        user.friendees.each do |f|
          f.posts << create(:post, user: f)
        end
      end
      it 'returns posts in reverse chronological order' do
        expect(Post.newsfeed_posts(user).first.created_at).to be > (Post.newsfeed_posts(user).last.created_at)
      end
      it 'does not throw an error if argument missing' do
        expect{Post.newsfeed_posts}.not_to raise_error
      end

    end
  end
end
