require 'rails_helper'

describe Post do

  let(:post){build(:post)}
  let(:user){create(:user)}
  describe "attributes" do

    it "is valid with default attributes" do
      expect(post).to be_valid
    end

    it "is saves with default attributes" do
      expect{post.save!}.to_not raise_error
    end

    it "is not valid without a body" do
      expect(build(:post, body: nil)).to_not be_valid
    end
  end

  describe "associations" do
    before do
      post.save
    end

    it "responds to author" do
      expect(post).to respond_to(:author)
    end

    it "responds to comments" do
      expect(post).to respond_to(:comments)
    end

    it "responds to likes" do
      expect(post).to respond_to(:likes)
    end

    context "on setting Author for post" do

      it "is valid when setting (valid) Author" do
        post.author = user
        expect(post).to be_valid
      end

      it "is not valid when setting nonexistent Author" do
        post.author_id = 12345
        expect(post).to_not be_valid
      end
    end

    context "on setting likes for post" do

      it "increases likes by 1" do
        like = Like.create(author_id: user.id)
        expect { post.likes << like }.to change { post.likes.count }.by(1)
      end

      it "decrements likes by 1" do
        like = Like.create(author_id: user.id)
        post.likes << like
        expect { post.likes.destroy(like)}.to change(post.likes, :count).by(-1)
      end
    end

    context "on setting comments for post" do

      it "increases comments by 1" do
        expect{post.comments.create}.to change(post.comments, :size).by(1)
      end

      it "decrements comments by 1" do
        comment = Comment.create
        post.comments << comment
        expect{post.comments.destroy(comment)}.to change(post.comments, :size).by(-1)
      end
    end
  end

end