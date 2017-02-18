require 'rails_helper'

describe Post do

  let(:user) { create(:user) }
  let(:post) { build(:post) }
  let(:comment) { build(:comment) }
  let(:like) { build(:like) }

  before do
    post.author = user
    post.save!
  end

  describe "associations" do

    it "belongs to an author" do
      should belong_to(:author)
    end

    it "has many likes" do
      should have_many(:likes)
    end

    it "has many comments" do
      should have_many(:comments)
    end

    context "upon deletion" do

      it "destroys its comments" do
        comment.author = user
        post.comments << comment
        comment.save!
        # "expect" needs block w/ action to perform
        # "change" needs block that produces num val expected to change as result
        expect{ post.destroy }.to change { Comment.count }.by(-1)
      end

      it "destroys its likes" do
        like.liker = user
        post.likes << like
        like.save!
        expect{ post.destroy }.to change { Like.count }.by(-1)
      end
    end
  end

  describe "validations" do

    it "accepts a body of text" do
      post.body = "ME AM GOOD WRITOR"
      expect(post.body).to eq("ME AM GOOD WRITOR")
    end

    it "rejects a body length less than 1 char" do
      post.body = ""
      expect(post).not_to be_valid
    end

    it "rejects a body length greater than 5000 chars" do
      long_text = ""
      5001.times { long_text << "X" }
      post.body = long_text
      expect(post).not_to be_valid
    end

  end

end