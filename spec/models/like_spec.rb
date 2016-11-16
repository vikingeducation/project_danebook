require 'rails_helper'

describe Like do
  let(:post_like){ create(:like, :on_post)}
  let(:comment_like){ create(:like, :on_comment) }

  it "is valid on a post" do
    expect(post_like).to be_valid
  end

  it "is valid on a comment" do
    expect(comment_like).to be_valid
  end

  specify "parents respond to their child associations" do
    expect(post_like.likeable).to respond_to(:likes)
    expect(comment_like.likeable).to respond_to(:likes)
  end

  it{ should belong_to(:likeable) }

  it{ should belong_to (:user) }

  context "when a user likes a post" do
    it "should not be allowed to like the same post" do
      like = create(:like, :on_post)
      user = like.user
      post = like.likeable
      another_like = build(:like, likeable: post, user: user)
      expect(another_like).not_to be_valid
  end
    it "should be allowed to like another post" do
      like = create(:like, :on_post)
      user = like.user
      another_like = build(:like, :on_post, user:user)
      expect(another_like).to be_valid
    end
end

  context "when a user likes a comment" do
    it "should not be allowed to like the same comment" do
      like = create(:like, :on_comment)
      user = like.user
      comment = like.likeable
      another_like = build(:like, likeable: comment, user: user)
      expect(another_like).not_to be_valid
    end
   it "should be allowed to like another comment" do
      like = create(:like, :on_comment)
      user = like.user
      another_like = build(:like, :on_comment, user:user)
      expect(another_like).to be_valid
    end
end

end