require "rails_helper"

describe Comment do

  let(:comment) { build(:post_comment) }

  context "Validations" do

    it "is valid with a body, a user_id and a post_id" do
      expect(comment).to be_valid
    end

    it "is invalid without a body" do
      comment.body = nil
      expect(comment).not_to be_valid
    end

    it "is invalid without a user_id" do
      comment.user_id = nil
      expect(comment).not_to be_valid
    end

    it "is invalid without a commentable_id" do
      comment.commentable_id = nil
      expect(comment).not_to be_valid
    end

    it "is invalid without a commentable_type" do
      comment.commentable_type = nil
      expect(comment).not_to be_valid
    end

    context "Body" do
      it "should have no more than 140 charactors" do
        comment.body = "a" * 141
        expect(comment).not_to be_valid
      end

      it "should have less than or equal to 140 charactors" do
        comment.body = "a" * 140
        expect(comment).to be_valid
      end
    end
  end

  context "Associations" do
    it "should respond to user" do
      expect(comment).to respond_to(:user)
    end
    it "should respond to commentable" do
      expect(comment).to respond_to(:commentable)
    end
    it "should respond to likes" do
      expect(comment).to respond_to(:likes)
    end
    it "should respond to profile" do
      expect(comment).to respond_to(:profile)
    end

    context "Dependency" do
      let(:comment) { create(:post_comment) }
      specify "Destroy a comment will also destroy a comment's likes" do
        like = comment.likes.create(attributes_for(:post_comment_like))
        binding.pry
        expect{ comment.destroy }.to change(Like, :count).by(-1)
        expect{ Like.find(like.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end