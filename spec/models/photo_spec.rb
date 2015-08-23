require "rails_helper"

describe Photo do
  let(:photo) { build(:photo) }

  context "Validations" do

    it "is valid with all attributes" do
      expect(photo).to be_valid
    end

  end

  context "Associations" do
    let(:photo) { create(:photo) }

    it "should respond to user" do
      expect(photo).to respond_to(:user)
    end

    it "should respond to comments" do
      expect(photo).to respond_to(:comments)
    end

    it "should respond to likes" do
      expect(photo).to respond_to(:likes)
    end

    context "Dependency" do
      let(:photo) { create(:photo) }
      let(:user) { create(:user) }
      specify "Destroy a photo will also destroy a photo's likes" do
        like = photo.likes.create(:user_id => user.id)
        expect{ photo.destroy }.to change(Like, :count).by(-1)
        expect{ Like.find(like.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end

      specify "Destroy a photo will also destroy a photo's comments" do
        comment = photo.comments.create(:user_id => user.id, :body => "body")
        expect{ photo.destroy }.to change(Comment, :count).by(-1)
        expect{ Comment.find(comment.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end