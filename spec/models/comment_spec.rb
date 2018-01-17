require 'rails_helper'

describe Comment, type: :model do

  let(:post_comment){ build(:comment_on_post) }
  let(:post_comment_author){ post_comment.user }
  let(:commented_post){ post_comment.post }
  let(:commented_post_author){ commented_post.user }

  # commenting on comments has not been implemented yet
  # let(:comment_comment){ build(:comment_on_comment) }
  # let(:comment_comment_author){ comment_comment.user }
  # let(:commented_comment){ comment_comment.comment }
  # let(:commented_comment_author){ commented_comment.user }

  describe "Associations" do
    it 'responds to author associations' do
      expect(post_comment).to respond_to(:user)
    end

    it 'responds to commentable associations' do
      expect(post_comment).to respond_to(:commentable)
    end

    it 'responds to likes associations' do
      expect(post_comment).to respond_to(:likes)
    end
  end #associations

  describe "Attributes" do

    it 'responds to body' do
      expect(post_comment).to respond_to(:body)
    end

  end #Attributes

  describe "Validations" do
    it "is valid with default attributes" do
      expect(post_comment).to be_valid
    end

    it "is invalid without a user" do
      comment = build(:comment_on_post, user_id: nil)
      expect(comment).to_not be_valid
    end

    it "is invalid without a body" do
      comment = build(:comment_on_post, body: nil)
      expect(comment).to_not be_valid
    end

    it "is invalid without a commentable parent type" do
      comment = build(:comment_on_post, commentable_type: nil)
      expect(comment).to_not be_valid
    end

    it "is invalid without a commentable parent id" do
      comment = build(:comment_on_post, commentable_id: nil)
      expect(comment).to_not be_valid
    end

  end #validations

  describe "Instance methods" do

    describe '#has_likes?' do
      let(:like){ create(:like_on_post_comment) }
      let(:comment){ like.likeable }

      it 'returns false if a comment has no likes' do
        expect(post_comment.has_likes?).to eq(false)
      end

      it 'returns true if a comment has at least one like' do
        expect(comment.has_likes?).to eq(true)
      end
    end
  end #instance methods

end #Comment
