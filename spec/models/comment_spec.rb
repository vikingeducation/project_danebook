require 'rails_helper'

describe Comment do
  let(:comment){ create(:comment, :for_post)}
  let(:like){ create(:comment_like, comment: comment)}
  context 'validations' do
    it 'is invalid without body' do
      comment.body = nil
      expect(comment).to be_invalid
    end
    it 'is invalid without user' do
      comment.user = nil
      expect(comment).to be_invalid
    end
  end
  it 'likes count is zero by default' do
    expect(comment.comment_likes_count).to eq(0)
  end

  context '#liked_by?' do
    it 'correctly tells us if comment is liked by a user' do
      user = create(:user, id: 77)
      like = create(:comment_like, user_id: 77, comment: comment)
      comment.comment_likes << like
      expect(comment.liked_by?(77)).to eq(true)
      expect(comment.liked_by?(5)).to eq(false)
    end
  end
  context 'associations' do
    it 'responds to comment_likes' do
      expect(comment).to respond_to(:comment_likes)
    end

  end

end
