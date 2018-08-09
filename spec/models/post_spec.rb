require 'rails_helper'

describe Post do

  let(:post){ create(:post) }

  describe "attributes" do

    it "with body and user is valid" do
      expect(post).to be_valid
    end

  end

  describe "user associations" do

    it "should responsd to user" do
      expect(post).to respond_to(:user)
    end

    specify "linking a valid user is successful" do
      new_user = create(:user)
      post.user = new_user
      expect(post).to be_valid
    end

    specify "linking an invalid user is not successful" do
      post.user_id = 12394
      expect(post).not_to be_valid
    end
  end

  describe "comment associations" do

    specify "linking to a valid comment is successful" do
      new_comment = create(:comment)
      post.comments << new_comment
      expect(post).to be_valid
    end

    it "should respond to comments" do
      expect(post).to respond_to(:comments)
    end

  end

  describe  "like associations" do
    it "responds to likes" do
      expect(post).to respond_to(:likes)
    end

    it "responds to user likes" do
      expect(post).to respond_to(:user_likes)
    end
  end

end
