require "rails_helper"

describe Like do
  let(:post_like) { build(:post_like) }
  let(:post_comment_like) { build(:post_comment_like) }
  let(:photo_comment_like) { build(:photo_comment_like) }

  context "Validations" do

    it "is valid with a user_id, a likable_id and a likable_type" do
      expect(post_like).to be_valid
    end

    it "is invalid without a user_id" do
      post_like.user_id = nil
      expect(post_like).not_to be_valid
    end

    it "is invalid without a likable_id" do
      post_like.likable_id = nil
      expect(post_like).not_to be_valid
    end

    it "is invalid without a likable_type" do
      post_like.likable_type = nil
      expect(post_like).not_to be_valid
    end

    context "Like" do
      before do
        post_like.save!
      end
      specify "One user can only like one likable object once." do
        new_like = build(:post_like, 
                          user_id: post_like.user_id,
                          likable_type: post_like.likable_type, 
                          likable_id: post_like.likable_id )
        expect(new_like).not_to be_valid
      end
    end

  end

  context "Associations" do
    context "Post like" do
      it "should respond to user" do
        expect(post_like).to respond_to(:user)
      end

      it "should respond to likable" do
        expect(post_like).to respond_to(:likable)
      end
    end

    context "Post comment like" do
      it "should respond to user" do
        expect(post_comment_like).to respond_to(:user)
      end

      it "should respond to likable" do
        expect(post_comment_like).to respond_to(:likable)
      end
    end

    context "Photo comment like" do
      it "should respond to user" do
        expect(photo_comment_like).to respond_to(:user)
      end

      it "should respond to likable" do
        expect(photo_comment_like).to respond_to(:likable)
      end
    end
  end
end