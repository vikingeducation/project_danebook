require 'rails_helper'

describe User do

  let(:user){build(:user)}
  let(:friender){create(:friender)}
  let(:friended){create(:friended)}

  describe "attributes" do

    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "saves with default attributes" do
      expect{user.save!}.to_not raise_error
    end

    context "on a new user" do

      it "should not be valid without a password" do
        expect(build(:user, password: nil)).to_not be_valid
      end

      it "should not be valid when password does not match password_confirmation" do
        expect(build(:user, password: "testing", password_confirmation: "password")).to_not be_valid
      end

      it "should not be valid with a short password" do
        expect(build(:user, password: "short")).to_not be_valid
      end

      it "should not be valid without first_name" do
        expect(build(:user, first_name: nil)).to_not be_valid
      end

      it "should not be valid without last_name" do
        expect(build(:user, last_name: nil)).to_not be_valid
      end

      it "should not be valid without email" do
        expect(build(:user, email: nil)).to_not be_valid
      end

      context "on saving with existing email" do
        before do
          user.save
        end
        it "should not be valid when saving with existing email" do
          expect(build(:user, email: user.email)).to_not be_valid
        end
      end

      it "generates token when user is created" do
        expect(user).not_to eq(nil)
      end
    end

    context "on an existing user" do

      before do
        user.save
      end

      it "should not raise error when updating valid attribute" do
        expect{user.update(first_name: "doug")}.to_not raise_error
      end

      it "should not be valid when password is changed to nil" do
        user.password = user.password_confirmation = ""
        expect(user).to_not be_valid
      end


      it "should be valid when changed to a new valid password" do
        user.password = user.password_confirmation = "testing"
        expect(user).to be_valid
      end

    end
  end

  describe "associations" do

    it "responds to posts" do
      expect(user).to respond_to(:posts)
    end

    it "responds to profile" do
      expect(user).to respond_to(:profile)
    end

    it "responds to comments" do
      expect(user).to respond_to(:comments)
    end

    it "responds to likes" do
      expect(user).to respond_to(:likes)
    end

    it "responds to users_friended_by" do
      expect(user).to respond_to(:users_friended_by)
    end

    it "responds to friended_users" do
      expect(user).to respond_to(:friended_users)
    end

    it "increases the friend count by one" do
      expect{friender.friended_users << friended}.to change(friender.friended_users, :count).by(1)
    end

    it "increases the users_friended_by count by one" do
      expect{friender.friended_users << friended}.to change(friended.users_friended_by, :count).by(1)
    end

    it "increases the friending count by one" do
      expect{friender.friended_users << friended}.to change(friender.initiated_friendings, :count).by(1)
    end
  end

  describe "methods" do

    before do
      user.save
    end

    it "regenerates a new token" do
      token = user.auth_token
      user.regenerate_auth_token
      expect(user.auth_token).to_not eq(token)
    end

    it "returns true if resource has been liked" do
      post = create(:post, author: user)
      post.likes.create(author_id: user.id)
      expect(user.liked_resource?(post)).to be(true)
    end

    it "returns the id of the liked resource" do
      post = create(:post, author: user)
      post.likes.create(author_id: user.id)
      expect(user.id_of_like(post)).to eq(post.id)
    end

    it "returns true for friended user" do
      friender.friended_users << friended
      expect(friender.friended_user?(friended)).to be(true)
    end
  end

end