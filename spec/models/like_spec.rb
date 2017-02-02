require 'rails_helper'

describe Like do
  let(:post_like){ build(:post_like) }
  let(:comment_like){ build(:comment_like) }

  describe 'polymorphic liking associations' do

    it { should belong_to(:user) }
    it { should belong_to(:likable) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:likable) }

    it 'likes respond to parent likable association' do
      expect(post_like).to respond_to(:likable)
      expect(comment_like).to respond_to(:likable)
    end

    it 'parents respond to child associations' do
      expect(post_like.likable).to respond_to(:likes)
      expect(comment_like.likable).to respond_to(:likes)
    end

    it 'likes do not allow invalid types' do
      invalid_like = build(:like, :likable_type => 'User')
      expect(invalid_like).not_to be_valid
    end

  end

end