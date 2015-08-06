require "rails_helper"

describe Post do
  let(:post) { build(:post) }

  context "Validations" do

    it "is valid with a body and a user_id" do
      expect(post).to be_valid
    end

    it "is invalid without a body" do
      post.body = nil
      expect(post).not_to be_valid
    end

    it "is invalid without a user_id" do
      post.user_id = nil
      expect(post).not_to be_valid
    end

    context "Body" do
      it "should have no more than 400 charactors" do
        post.body = "a" * 401
        expect(post).not_to be_valid
      end

      it "should have less than or equal to 400 charactors" do
        post.body = "a" * 400
        expect(post).to be_valid
      end
    end
  end

  context "Associations" do
    it "should respond to user" do
      expect(post).to respond_to(:user)
    end
    it "should respond to posts" do
      expect(post).to respond_to(:likes)
    end
    it "should respond to comments" do
      expect(post).to respond_to(:comments)
    end
  end
end
