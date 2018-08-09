require 'rails_helper'

describe User do

  let(:user){ create(:user) }

  describe "attributes" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end
    it "is invalid with invalid attributes" do
      new_user = build(:user, email: "")
      expect(new_user).not_to be_valid
    end
  end
  
  describe "validations" do
    it "with a duplicate email is invalid" do
      new_user = build(:user, email: user.email)
      expect(new_user).not_to be_valid
    end
    it "with less than 3 characters in email is invalid" do
      pw = "12"
      new_user = build(:user, password: pw, password_confirmation: pw)
      expect(new_user).not_to be_valid
    end
  end

  describe "associations" do
    it "responds to profile association" do
      expect(user).to respond_to(:profile)
    end
    it "responds to post association" do
      expect(user).to respond_to(:posts)
    end
    it "responds to comments association" do
      expect(user).to respond_to(:comments)
    end
    it "responds to likes association" do
      expect(user).to respond_to(:likes)
    end
  end

  describe "methods" do
    describe "#generate_token" do
      it "generates a random auth token before creating user" do
        new_user = create(:user)
        expect(new_user[:auth_token]).not_to be_nil
      end
    end
    describe "#regenerate_auth_token" do
      it "re-generates an auth token for a given user" do
        starting_auth = user[:auth_token]
        expect(user.regenerate_auth_token).not_to eq(starting_auth)
      end
    end
  end

end
