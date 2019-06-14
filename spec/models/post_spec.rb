require 'rails_helper'

describe Post, type: :model do
  let(:post){ build(:post) }
  let(:user){ post.user }

  describe "Associations" do
    it 'responds to user associations' do
      expect(post).to respond_to(:user)
    end

    it 'responds to likes associations' do
      expect(post).to respond_to(:likes)
    end

    it 'responds to comments associations' do
      expect(post).to respond_to(:comments)
    end
  end #associations

  describe "Attributes & Validations" do
    it "is valid with default attributes" do
      expect(post).to be_valid
    end

    it "saves with default attributes" do
      expect{ post.save! }.not_to raise_error
    end

    it 'with a user and body is valid' do
      expect(post).to be_valid
    end

    it 'without a user is invalid' do
      post = build(:post, :user => nil)
      expect(post).to_not be_valid
    end

    it 'without a body is invalid' do
      post = build(:post, :body => nil)
      expect(post).to_not be_valid
    end
  end #validations

  describe "Instance methods" do
    describe '#has_likes?' do
      let(:like){ create(:like_on_post)}
      let(:post_1){ like.likeable }

      it 'returns false if a post has 0 likes' do
        post.likes.destroy_all
        expect(post.has_likes?).to eq(false)
      end

      it 'returns true if a post has at least 1 like' do
        expect(post_1.has_likes?).to eq(true)
      end
    end

    describe '#has_comments?' do
      let(:comment){ create(:comment_on_post) }
      let(:post_1){ comment.commentable }

      it 'returns false if a post has 0 comments' do
        post.comments.destroy_all
        expect(post.has_comments?).to eq(false)
      end

      it 'returns true if a post has at least 1 comment' do
        expect(post_1.has_comments?).to eq(true)
      end
    end
  end #instance methods

end #post
