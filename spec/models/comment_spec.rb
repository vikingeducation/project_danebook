require 'rails_helper'

describe Comment do

  let(:valid_comment){ create(:comment) }

  describe "attributes" do

    it "with body, user and comment/post it is valid" do
      expect(valid_comment).to be_valid
    end
  end

  describe "user associations" do

    specify "linking a valid user is successful" do
      author = create(:user)
      valid_comment.user = author
      expect(valid_comment).to be_valid
    end

    specify "linking an invalid user is not successful" do
      valid_comment.user_id = 12345
      expect(valid_comment).not_to be_valid
    end

  end

  describe "post associations" do

    specify "linking a valid post is successful" do
      parent_post = create(:post)
      valid_comment.commentable_id = parent_post.id
      expect(valid_comment).to be_valid
    end

    specify "linking an invalid post is not successful" do
      valid_comment.commentable_id = 12345
      expect(valid_comment).not_to be_valid
    end

  end

  describe "photo associations" do

    specify "linking a valid photo is successful" do
      parent_photo = create(:photo)
      valid_comment.commentable_id = parent_photo.id
      valid_comment.commentable_type = "Photo"
      expect(valid_comment).to be_valid
      expect(valid_comment.commentable_id).to eq(parent_photo.id)
    end

    specify "linking an invalid photo is not successful" do
      parent_photo = create(:photo)
      valid_comment.commentable_id = 12354
      valid_comment.commentable_type = "Photo"
      expect(valid_comment).not_to be_valid
    end

  end


  describe "like associations" do

    it "responds to likes" do
      expect(valid_comment).to respond_to(:likes)
    end

  end


end
