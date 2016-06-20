require 'rails_helper'

describe User do 
  let(:user){ create(:user) }

  context "validation" do 
    it "should be valid with common attributes" do
      expect(user).to be_valid
    end

    it "should not be valid if email is missing" do
      invalid_email = [nil, "", " "]
      invalid_email.each do |email|
        user.email = email
        expect(user).not_to be_valid
      end
    end

    it "should not be valid if email is invalid" do
      invalid_email = ["an_email", "my@email", "email.com"]
      invalid_email.each do |email|
        user.email = email
        expect(user).not_to be_valid
      end
    end

    it "should not be valid if password is missing" do
      invalid_password = [nil, "", " "]
      invalid_password.each do |password|
        user.password = password
        expect(user).not_to be_valid
      end
    end

    it "should not be valid if the password is too short or too long" do
      invalid_password = ["a"*7, "a"*25]
      invalid_password.each do |password|
        user.password = password
        expect(user).not_to be_valid
      end
    end
  end

  context "association" do
    it "shoud respond to a Profile association" do
      expect(user).to respond_to(:profile) 
    end

    it "shoud respond to a Posts association" do
      expect(user).to respond_to(:posts)
    end

    it "should respond to the Comments association" do
      expect(user).to respond_to(:comments)
    end

    it "should respond to the Liked_posts association"
    it "should respond to the Liked_comments association"
  end

  context "classMethod" do

    describe "#full_name" do

      it "should return the full_name of the user" do
        profile = create(:profile, user: user)
        profile.first_name = "john"
        profile.last_name = "youth"

        expect(user.full_name).to eq("john youth")
      end
    end
  end
end
