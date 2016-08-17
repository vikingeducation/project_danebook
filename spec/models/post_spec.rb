require 'rails_helper'

describe Post do
  let(:post) { build(:post) }

  describe "Validations" do
    it "creates a post with valid attributes" do
      expect(post).to be_valid
    end

    it "validates post text length" do
      is_expected.to validate_length_of(:text).is_at_least(1).is_at_most(1000)
    end

    it "doesn't let SQL injection delete the database" do
      create(:post, text: "'); DROP TABLE posts;")
      expect(Post.count).to eql(1)
    end
  end

  describe "Associations" do
    it "has many likes" do
      is_expected.to have_many :likes
    end

    it "has many comments" do
      is_expected.to have_many :comments
    end

    it "was written by an author" do
      is_expected.to belong_to :author
    end

    specify "linking a valid Author succeeds" do
      author = create( :user )
      post.author = author
      expect( post ).to be_valid
    end

    specify "linking nonexistent author fails" do
      post.author_id = 1234
      expect( post ).not_to be_valid
    end
  end
end
