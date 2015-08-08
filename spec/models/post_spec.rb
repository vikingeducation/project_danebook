require 'rails_helper'

describe Post do

  let(:post){ build(:post) }
  let(:user){ create(:user) }

  it "is valid with default attributes" do
    expect(post).to be_valid
  end

  describe "validations" do

    it "must have a body" do
      post.body = nil
      expect(post).not_to be_valid
    end

    it "must have an author" do
      post.author = nil
      expect(post).not_to be_valid
    end

    it "must have a recipient" do
      post.recipient_user = nil
      expect(post).not_to be_valid
    end

  end

  describe "methods" do

    describe "#liked?" do

      it "returns nil if a relationship doesn't exist" do
        expect(post.liked_by?(user)).to be nil
      end

      it "returns a relation if the user liked the comment" do
        post.save
        create(:post_like, user_id: user.id, likeable: post)
        expect(post.liked_by?(user)).to be_a(Like)
      end
    end

  end

  describe "associations" do

    context "likes" do

      let(:post){ create(:post) }

      it "can be liked" do
        expect(post).to respond_to(:likes)
      end

      it "can be liked multiple times" do
        3.times { post.likes << create(:post_like) }
        expect(post.likes.count).to eq(3)
      end

      it "can only be liked once by the same user" do
        create(:post_like, 
                user_id: user.id, 
                likeable: post)
        second_like = build(:post_like, 
                            user_id: user.id, 
                            likeable: post)
        expect(second_like).not_to be_valid
      end

    end

    context "author" do

      it "has an author" do
        expect(post).to respond_to(:author)
      end

      specify "author is a user" do
        expect(post.author).to be_a(User)
      end

    end

    context "child comments" do

      let(:post){ create(:post) }

      it "can be commented on" do
        expect(post).to respond_to(:comments)
      end

      it "can be commented on multiple times" do
        3.times { post.comments << create(:post_comment) }
        expect(post.comments.count).to eq(3)
      end

    end

  end

end