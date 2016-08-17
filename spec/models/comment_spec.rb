require 'rails_helper'

describe Comment do
  let(:comment_comment) { create(:comment_comment) }
  let(:post_comment) { create(:post_comment) }

  describe "Validations" do
    it "creates a comment with valid attributes" do
      expect(post_comment).to be_valid
    end

    it "validates text length" do
      is_expected.to validate_length_of(:text).is_at_least(1).is_at_most(1000)
    end
  end

  describe "Associations" do
    it "has many likes" do
      is_expected.to have_many :likes
    end

    it "has many comments" do
      is_expected.to have_many :comments
    end

    it "belongs to a commenter" do
      is_expected.to belong_to :commenter
    end

    it "responds to commentable" do
      expect(post_comment).to respond_to :commentable
    end

    specify "linking a valid commenter succeeds" do
      commenter = create( :user )
      post_comment.commenter = commenter
      expect( post_comment ).to be_valid
    end

    specify "linking nonexistent commenter fails" do
      post_comment.commenter_id = 1234
      expect( post_comment ).not_to be_valid
    end

    specify "linking a valid commentable succeeds" do
      commentable = create( :post )
      post_comment.commentable = commentable
      expect( post_comment ).to be_valid
    end

    specify "linking nonexistent commentable fails" do
      post_comment.commentable_id = 1234
      expect( post_comment ).not_to be_valid
    end
  end

end
