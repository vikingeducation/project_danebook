require 'rails_helper'

describe Comment do 
  let(:comment){ create(:comment) }
  context "validation" do

    it "should be valid with correct attributes" do
      expect(comment).to be_valid
    end

    it "should not be valid without a body" do
      invalid_attributes(comment, "body=")
    end

    it "should not be valid without an author" do
      invalid_attributes(comment, "user_id=")
    end

    it "should not be valid if the user doesn't exist" do
      user = create(:user)
      comment.user_id = user.id
      user.destroy
      expect(comment).not_to be_valid
    end

    it "should not be valid without a post parent" do
      invalid_attributes(comment, "post_id=")
    end

    it "should not be valid if the post doesnt exist" do
      post = create(:post)
      comment.post_id = post.id
      post.destroy
      expect(comment).not_to be_valid
    end
  end

  context "Association" do
    it "should respond to the Author association" do 
      expect(comment).to respond_to(:author)
    end

    it "should respond to the Post association" do
      expect(comment).to respond_to(:post)
    end

    it "should respond to the Users_liked association"

  end
end