require 'rails_helper'

describe Post do 
  let(:post){ create(:post) }
  context "Validation" do
    it "should be valid with common attributes" do
      expect(post).to be_valid
    end

    it "should not be valid with a body missing" do
      invalid_attributes(post, "body=")
    end

    it "should not be valid with a author missing" do
      invalid_attributes(post, "author_id=")
    end

    it "should not be valid if the author doesnt exist" do
      user = create(:user)
      post.author_id = user.id
      user.destroy
      expect(post).not_to be_valid
    end
  end

  context "Association" do
    it "should respond to the Author association" do 
      expect(post).to respond_to(:author)
    end

    it "should respond to the Comments association" do
      expect(post).to respond_to(:comments)
    end

    it "should respond to the Users_liked association"
  end
end