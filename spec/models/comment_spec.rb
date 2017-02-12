require 'rails_helper'

describe Comment do

  let(:user) { create(:user) }
  let(:post) { build(:post) }
  let(:comment) { build(:comment) }
  let(:like) { build(:like) }

  before do
    post.author = user
    post.save!
    comment.author = user
    post.comments << comment
  end

  describe "associations" do

    it "belongs to an author" do
      should belong_to(:author)
    end

    it "belongs to a commentable thing" do
      should belong_to(:commentable)
    end

    it "has many likes" do
      should have_many(:likes)
    end

    context "upon deletion" do

      it "destroys its likes" do
        like.liker = user
        comment.likes << like
        like.save!
        expect{ comment.destroy }.to change { Like.count }.by(-1)
      end
    end

  end

  describe "validations" do

    it "accepts a body of text" do
      comment.body = "ME AM GOOD WRITOR"
      expect(comment.body).to eq("ME AM GOOD WRITOR")
    end

    it "rejects a body length less than 1 char" do
      comment.body = ""
      expect(comment).not_to be_valid
    end

    it "rejects a body length greater than 5000 chars" do
      long_text = ""
      5001.times { long_text << "X" }
      comment.body = long_text
      expect(comment).not_to be_valid
    end

  end

end