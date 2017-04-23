require 'rails_helper'

describe CommentLike do
  let(:user){ create(:user)}
  let(:comment){ create(:comment)}
  let(:like){ create(:like)}
  context 'validations' do
    it 'does not allow duplicate likes' do
      like = create(:comment_like, user: user, comment: comment)
      expect{ create(:comment_like, user: user, comment: comment)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context 'associations' do
    it 'automatically updates like counts on parent ' do
      expect{ create_list(:comment_like, 2, comment: comment)}.to change(comment, :comment_likes_count).by(2)
      expect{ comment.comment_likes.destroy_all}.to change(comment, :comment_likes_count).by(-2)
    end
  end
end
