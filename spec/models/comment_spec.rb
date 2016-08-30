require 'rails_helper'

describe Comment do
  let(:comment) { build(:comment) }
  let(:post) { build(:post) }
  let(:user) { build(:user) }

  it "accepts a body with at least 4 characters" do
    should validate_length_of(:body).is_at_least(4)
  end

  it "accepts a body with no more than 3000 characters" do
    should validate_length_of(:body).is_at_most(3000)
  end

  describe "associations" do
    it "belongs to a user" do
      expect(comment).to belong_to(:user)
    end

    it "belongs to a commentable parent" do
      expect(comment).to belong_to(:commentable)
    end

    it "has many comments, as a commentable parent" do
      expect(comment).to have_many(:comments)
    end

    it "has many likes, as a likeable parent" do
      expect(comment).to have_many(:likes)
    end
  end

  describe "#liked?" do

    context "when passed a user as an argument" do
      it "returns true when it has been liked by a specified user" do
        user.save
        comment.save
        comment.likes.create(user: user)
        expect(comment.liked?(user)).to be(true)
      end

      it "returns false when it has not been liked by a specified user" do
        user.save
        comment.save
        comment.likes.create(user: user)
        other_user = create(:user)
        expect(comment.liked?(other_user)).to be(false)
      end
    end

    it "returns true when the comment has been liked at all" do
      liked_post = build(:comment,:with_likes)
      expect(liked_post.liked?).to be(true)
    end

  end

  describe "#like" do

    context "when passed a user as an argument" do
      it "returns the last like that the user made on the comment" do
        user.save
        comment.save
        comment.likes.create(user: user)
        user_like = comment.likes.last
        2.times do
          other_user = create(:user)
          comment.likes.create(user: other_user)
        end
        expect(comment.like(user)).to eq(user_like)
      end
    end

    it "returns the last like made on the comment" do
      liked_post = build(:comment,:with_likes)
      last_like = liked_post.likes.last
      expect(liked_post.like).to eq(last_like)
    end

  end

  describe "nested attributes" do

    it "accepts nested attributes for comments" do
      should accept_nested_attributes_for(:comments)
    end

    it "accepts nested attributes for likes" do
      should accept_nested_attributes_for(:likes)
    end
  end

end