require 'rails_helper'

describe Post do
  let(:post){ build(:post)}
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
      post.save
      expect(post.liked_by?(user.id)).to eq(true)
      expect(post.liked_by?(5)).to eq(false)
    end
  end
end
