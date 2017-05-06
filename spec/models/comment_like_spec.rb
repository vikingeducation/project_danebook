require 'rails_helper'

describe Like do
  let(:user){ build(:user)}
  let(:comment){ build(:comment, :for_post)}
  let(:like){ build(:like)}
  let(:posting){ build(:post) }
  context 'validations' do
    it 'does not allow duplicate likes' do
      like = create(:like, user: user, likeable: comment)
      expect{ create(:like, user: user, likeable: comment)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context 'associations' do
    it 'automatically updates like counts on parent ' do
      expect{ create_list(:like, 2, likeable: comment)}.to change(comment, :likes_count).by(2)
      comment.likes.destroy_all
      expect{ comment.reload }.to change(comment, :likes_count).by(-2)
    end
  end
end
