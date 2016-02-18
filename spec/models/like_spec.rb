require 'rails_helper'

describe Like do

  let(:post_like) { build(:post_like) }
  let(:comment_like) { build(:comment_like) }

  describe "attributes" do
    it "builds with valid attributes" do
      expect(post_like).to be_valid
      expect(comment_like).to be_valid
    end

    it "invalidates a nil user (needs a user)" do
      new_post_like = build(:post_like, user: nil)
      new_comment_like = build(:comment_like, user: nil)
      expect(new_post_like).to_not be_valid
      expect(new_comment_like).to_not be_valid
    end

    it "invalidates a nil likeable (needs a parent)" do
      new_post_like = build(:post_like, likeable: nil)
      new_comment_like = build(:comment_like, likeable: nil)
      expect(new_post_like).to_not be_valid
      expect(new_comment_like).to_not be_valid
    end

    it "doesn't allow user to like the same thing twice" do
      user_1 = create(:user)
      post_1 = create(:post, user: user_1 )
      new_post_like_1 = create(:post_like, likeable: post_1, user: user_1)
      new_post_like_2 = build(:post_like, likeable: post_1, user: user_1)
      expect(new_post_like_2).to_not be_valid
    end
  end

  describe "associations" do

    let(:post_like) { create(:post_like) }
    let(:comment_like) { create(:comment_like) }

    it "responds to the user association" do
      expect(post_like).to respond_to(:user)
      expect(post_like).to respond_to(:user)
    end

    describe "polymorphic like associations" do
      it "respond to the likeable association" do
        expect(post_like).to respond_to(:likeable)
        expect(comment_like).to respond_to(:likeable)
      end

      it "parents respond to their child associations" do
        expect(post_like.likeable).to respond_to(:likes)
        expect(comment_like.likeable).to respond_to(:likes)
      end
    end
  end
end
