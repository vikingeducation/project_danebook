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
      valid_comment.post = parent_post
      expect(valid_comment).to be_valid
    end

    specify "linking an invalid post is not successful" do
      valid_comment.post_id = 12345
      expect(valid_comment).not_to be_valid
    end

  end

end
