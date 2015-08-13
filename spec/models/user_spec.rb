require "rails_helper"

describe User do
  
  let(:user) { build(:user) }

  context "Validations" do

    it "is valid with an email, a password" do
      expect(user).to be_valid
    end

    it "is invalid without a email" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "is invalid without a password" do
      user.password = nil
      expect(user).not_to be_valid
    end

    context "Email" do
      before do
        user.save!
      end

      it "is invalid with a duplicate email address" do
        new_user = build(:user, email: user.email)
        expect(new_user).not_to be_valid
      end
    end

    context "Password" do
      it "should have length no less than 6" do
        user.password = "a" * 5
        expect(user).not_to be_valid
      end

      it "should have length no more than 20" do
        user.password = "a" * 21
        expect(user).not_to be_valid
      end

      it "should have length more than or equal to 6" do
        user.password = "a" * 6
        expect(user).to be_valid
      end

      it "should have length less than or equal to 20" do
        user.password = "a" * 20
        expect(user).to be_valid
      end
    end

  end

  context "Associations" do
    it "should respond to profile" do
      expect(user).to respond_to(:profile)
    end
    it "should respond to posts" do
      expect(user).to respond_to(:posts)
    end
    it "should respond to comments" do
      expect(user).to respond_to(:comments)
    end
    it "should respond to likes" do
      expect(user).to respond_to(:likes)
    end
    it "should respond to initiated_friendings" do
      expect(user).to respond_to(:initiated_friendings)
    end
    it "should respond to received_friendings" do
      expect(user).to respond_to(:received_friendings)
    end
    it "should respond to friended_users" do
      expect(user).to respond_to(:friended_users)
    end
    it "should respond to users_friended_by" do
      expect(user).to respond_to(:users_friended_by)
    end
    it "should respond to photos" do
      expect(user).to respond_to(:photos)
    end
    it "should respond to profile_photo" do
      expect(user).to respond_to(:profile_photo)
    end
    it "should respond to cover_photo" do
      expect(user).to respond_to(:cover_photo)
    end

    context "Dependency" do
      let(:user) { create(:user) }
      specify "Destroy a user will also destroy a user's posts" do
        # post = user.posts.create(attributes_for(:post))
        post = create(:post, :user_id => user.id)
        expect{ user.destroy }.to change(Post, :count).by(-1)
        expect{ Post.find(post.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
      specify "Destroy a user will also destroy a user's comments" do
        comment = create(:post_comment, :user_id => user.id)
        expect{ user.destroy }.to change(Comment, :count).by(-1)
        expect{ Comment.find(comment.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
      specify "Destroy a user will also destroy a user's likes" do
        like = create(:post_like, :user_id => user.id)
        expect{ user.destroy }.to change(Like, :count).by(-1)
        expect{ Like.find(like.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
      specify "Destroy a user will also destroy a user's photos" do
        photo = create(:photo, :user_id => user.id)
        expect{ user.destroy }.to change(Photo, :count).by(-1)
        expect{ Photo.find(photo.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end









