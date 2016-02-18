require 'rails_helper'

describe Comment do

  let(:comment) { build(:comment) }
  let(:user) { create(:user) }
  describe "attributes" do
    it "is valid with default attributes" do
      expect(comment).to be_valid
    end

    context "in creation of comment" do
      it "able to create a comment with valid author" do
        comment.author = user
        expect(comment).to be_valid
      end

      it "is not valid without author" do
        comment.author = nil
        expect(comment).to_not be_valid
      end

      it "is not valid with a non existent author" do
        comment.author_id = 12345
        expect(comment).to_not be_valid
      end
    end
  end

  describe "association" do

    it "can have post as a commentable parent" do
      comment.commentable = post = create(:post)
      expect(comment.commentable_id).to eq(post.id)
    end

    it "responds to likes" do
      expect(comment).to respond_to(:likes)
    end
  end



end