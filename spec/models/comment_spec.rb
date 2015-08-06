require "rails_helper"

describe Comment do
  let(:comment) { build(:comment) }

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

    it "is invalid without a post_id" do
      comment.post_id = nil
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
    it "should respond to post" do
      expect(comment).to respond_to(:post)
    end
    it "should respond to likes" do
      expect(comment).to respond_to(:likes)
    end
  end
end