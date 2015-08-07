
require 'rails_helper'

describe Comment do

  let(:post_comment){ build(:post_comment) }
  let(:user){ create(:user) }

  it "is valid with default attributes" do
    expect(post_comment).to be_valid
  end

  describe "validations" do

    it "must have a body" do
      post_comment.body = nil
      expect(post_comment).not_to be_valid
    end

    it "must have an author" do
      post_comment.author = nil
      expect(post_comment).not_to be_valid
    end

    it "must have a parent" do
      post_comment.commentable = nil
      expect(post_comment).not_to be_valid
    end

  end

  describe "methods" do

    describe "#liked?" do

      it "returns nil if a relationship doesn't exist" do
        expect(post_comment.liked_by?(user)).to be nil
      end

      it "returns a relation if the user liked the comment" do
        create(:comment_like, user_id: user.id, likeable: post_comment)
        expect(post_comment.liked_by?(user)).to be_a(Like)
      end
    end

  end

  describe "associations" do

    context "likes" do

      let(:post_comment){ create(:post_comment) }

      it "can be liked" do
        expect(post_comment).to respond_to(:likes)
      end

      it "can be liked multiple times" do
        3.times { post_comment.likes << create(:comment_like) }
        expect(post_comment.likes.count).to eq(3)
      end

      it "can only be liked once by the same user" do
        create(:comment_like, 
                user_id: user.id, 
                likeable: post_comment)
        second_like = build(:comment_like, 
                            user_id: user.id, 
                            likeable: post_comment)
        expect(second_like).not_to be_valid
      end

    end

    context "author" do

      it "has an author" do
        expect(post_comment).to respond_to(:author)
      end

      specify "author is a user" do
        expect(post_comment.author).to be_a(User)
      end

    end

    context "child comments" do

      let(:post_comment){ create(:post_comment) }

      it "can be commented on" do
        expect(post_comment).to respond_to(:comments)
      end

      it "can be commented on multiple times" do
        3.times { post_comment.comments << create(:comment_comment) }
        expect(post_comment.comments.count).to eq(3)
      end

    end

  end

end