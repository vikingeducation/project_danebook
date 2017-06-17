require "rails_helper"

describe Post do
  let(:post_){ create(:post_) }
  let(:user){ create(:user) }

  context "associations" do
    it "belongs to a user" do
      expect{post_.user}.not_to raise_error
    end

    it "has many likes" do
      expect{post_.likes}.not_to raise_error
    end

    it "has many comments" do
      expect{post_.comments}.not_to raise_error
    end
  end

  context "liked_by_user?" do
    it "takes an user id and returns the like object if it is liked by him" do
      post_.likes.create(user_id: user.id)
      expect(post_.liked_by_user?(user.id)).to eq(Like.first)
    end

    it "returns nil if is not liked by the given user" do
      expect(post_.liked_by_user?(user.id)).to be nil
    end
  end

end
