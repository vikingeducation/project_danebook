require 'rails_helper'

describe Post do
  let(:post) { build(:post) }
  let(:user) { build(:user) }

  describe "body" do
    it "validates the presence of a body" do
      should validate_presence_of(:body)
    end

    it "accepts a body with at least 10 characters" do
      should validate_length_of(:body).is_at_least(10)
    end

    it "accepts a body with at most 10 characters" do
      should validate_length_of(:body).is_at_most(20000)
    end

    it "accepts a title with at least 4 characters" do
      should validate_length_of(:title).is_at_least(4)
    end

    it "accepts a title with at most 60 characters" do
      should validate_length_of(:title).is_at_most(60)
    end

  end

  describe "associations" do
    it "has many comments" do
      expect(post).to have_many(:comments)
    end

    it "has many likes" do
      expect(post).to have_many(:likes)
    end

  end

  describe "#liked?" do

    it "returns true when it has been liked by a specified user" do
      user.save
      post.save
      post.likes.create(user: user)
      # create user, create post, post.user = user
      expect(post.liked?(user)).to be(true)
    end

  end

  # like -> likeable -> post,comment

end