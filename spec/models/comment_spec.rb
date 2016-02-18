require 'rails_helper'

describe Comment do

  let(:post_comment) { build(:post_comment) }

  describe "attributes" do
    it "builds with valid attributes" do
      expect(post_comment).to be_valid
    end

    it "invalidates a nil body" do
      new_post_comment = build(:post_comment, body: nil)
      expect(new_post_comment).to_not be_valid
    end

    it "invalidates a nil user (needs a user)" do
      new_post_comment = build(:post_comment, user: nil)
      expect(new_post_comment).to_not be_valid
    end

    it "invalidates a nil commentable (needs a parent)" do
      new_post_comment = build(:post_comment, commentable: nil)
      expect(new_post_comment).to_not be_valid
    end
  end

  describe "associations" do

    let(:new_post_comment) { create(:post_comment) }

    it "responds to the user association" do
      expect(new_post_comment).to respond_to(:user)
    end

    it "responds to the likes association" do
      expect(new_post_comment).to respond_to(:likes)
    end

    describe "polymorphic comment associations" do
      it "respond to the commentable association" do
        expect(new_post_comment).to respond_to(:commentable)
      end

      it "parents respond to their child associations" do
        expect(new_post_comment.commentable).to respond_to(:comments)
      end
    end
  end
end
