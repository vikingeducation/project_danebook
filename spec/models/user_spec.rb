require 'rails_helper'

describe User do

  let(:user) { create(:user) }

  describe "instance & class methods" do

    it "generates an auth token before creation of a user" do
      expect(user.auth_token).not_to eq(nil)
    end

    it "can regenerate an auth token" do
      user.auth_token = "boats"
      user.regenerate_auth_token
      expect(user.auth_token).not_to eq("boats")
    end

    it "can output the user's full name" do
      expect(user.full_name).to eq("Bob Dobbs")
    end

    context "when no search terms are given" do
      it "finds the first user in the database" do
        user
        expect(User.user_search(nil).first).to eq(user)
      end
    end

    context "when a valid search term is given" do
      it "finds the first user in the database" do
        user
        expect(User.user_search("Bob").first).to eq(user)
      end
    end

    context "when it friends a user" do
      it "can output info about that friend" do
        diff_user = create(:user, :diff_user)
        user.friended_users << diff_user
        expect(user.friends.first.first_name).to eq("Bill")
      end
    end

    context "when friended by a user" do
      it "can output info about that friend" do
        diff_user = create(:user, :diff_user)
        user.users_friended_by << diff_user
        expect(user.friends.first.first_name).to eq("Bill")
      end
    end

  end

  describe "associations" do

    it "has one profile" do
      should have_one(:profile)
    end

    it "has many authored posts" do
      should have_many(:authored_posts)
    end

    it "has many comments" do
      should have_many(:comments)
    end

    it "has many liked things" do
      should have_many(:liked_things)
    end

    it "has many photos" do
      should have_many(:photos)
    end

    it "accepts nested attributes for profile" do
      should accept_nested_attributes_for(:profile)
    end

    it "has many initiated/received friendings & many users friended" do
      should have_many(:initiated_friendings)
      should have_many(:received_friendings)
      should have_many(:friended_users)
      should have_many(:users_friended_by)
    end

  end

  describe "validations" do

    it "accepts a valid user" do
      expect(user).to be_valid
    end

    it "saves a valid user" do
      # a bit redundant, but... whatever
      new_user = build(:user)
      expect{ new_user.save! }.not_to raise_error
    end

    it "has a secure password" do
      should have_secure_password
    end

    it "rejects a user with no first_name" do
      new_user = build(:user, :no_first_name)
      expect(new_user).not_to be_valid
    end

    it "rejects a user with no last_name" do
      new_user = build(:user, :no_last_name)
      expect(new_user).not_to be_valid
    end

    it "rejects a user with no email" do
      new_user = build(:user, :no_email)
      expect(new_user).not_to be_valid
    end

    context "when saving multiple users" do
      it "rejects a user with a duplicate email address" do
        # when "user.email" is called, it creates "user", then extracts its email for use on "new_user"
        new_user = build(:user, email: user.email)
        expect(new_user).not_to be_valid
      end
    end
    
  end

end