require 'rails_helper'

describe Like do

  let(:post_like){ build(:post_like) }
  let(:comment_like){ build(:comment_like) }

  it "is valid with default attributes" do
    expect(post_like).to be_valid
  end

  describe "validations" do

    it "must have an 'author'" do
      post_like.user = nil
      expect(post_like).not_to be_valid
    end

    it "must have a likeable type" do
      post_like.likeable = nil
      expect(post_like).not_to be_valid
    end

  end

  describe "methods" do

    describe "#search_record" do

      let(:post) { create(:post) }
      let(:user) { create(:user) }

      it "returns nil if a relationship doesn't exist" do
        expect(Like.search_record(post.class.to_s, post.id, user.id)).to be nil
      end

      it "returns a relation if the user liked the likeable" do
        create(:post_like, user_id: user.id, likeable: post)
        expect(Like.search_record(post.class.to_s, post.id, user.id)).to be_a(Like)
      end
    end

  end

end