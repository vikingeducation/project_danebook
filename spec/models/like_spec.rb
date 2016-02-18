require 'rails_helper'

describe Like do
  let(:like) { build(:like) }
  let(:post_like) { build(:post_like) }

  describe "attributes" do
    it "is not valid without a user" do
      authorless_like = build(:like, author: nil)
      expect(authorless_like).to_not be_valid
    end
  end

  describe "polymorphic associations" do

    it "responds to their parent association" do
      expect(post_like).to respond_to(:likeable)
    end

    it "parents responds to the children" do
      post_like.save!
      expect(post_like.likeable).to respond_to(:likes)
    end

    it "is not valid without a parent user" do
      postless_like = build(:like, likeable: nil)
      expect(postless_like).to_not be_valid
    end

    it "is valid with a parent" do
      expect(post_like).to be_valid
    end

  end

end