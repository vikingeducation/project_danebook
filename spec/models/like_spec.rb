require 'rails_helper'

describe Like do

  let(:user) { build(:user) }
  let(:post) { build(:post) }
  let(:like) { build(:like) }

  context "without belonging to a post/comment/photo" do

    it "is invalid" do
      expect(like).not_to be_valid
    end

  end

  context "with a valid like" do

    before do
      post.author = user
      post.save!
      like.liker = user
      post.likes << like
      like.save!
    end

    it "can be removed" do
      expect{ like.destroy }.to change{ Like.count }.by(-1)
    end

    it "the same user cannot like the same post more than once" do
      expect{ post.likes << like }.to change{ post.likes.count }.by(0)
    end

  end

end