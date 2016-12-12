require 'rails_helper'
require 'factory_girl_rails'
describe User do

  let ( :user ) { build(:user) }

  describe "validations" do 
    it 'Can be created' do
      expect(user).to be_valid
    end

    it 'expect an user with no password to fail' do
      user = build(:user, password: "")
      expect(user).to_not be_valid
    end

    it 'expect an user with a repeated email to fail' do
      user2 = create(:user, email: "foo@yahoo.com")
      user = build(:user, email: "foo@yahoo.com")
      expect(user).to_not be_valid
    end

    it 'expect an user with no last name to fail' do
      user = build(:user, last_name: "")
      expect(user).to_not be_valid
    end

    it 'expect an user with no first name to fail' do
      user = build(:user, first_name: "")
      expect(user).to_not be_valid
    end

    it 'expect an user with too short a password to fail' do
      user = build(:user, password: "123")
      expect(user).to_not be_valid
    end
  end

  # associations
  describe "associations" do
    it "expect an user to have a profile" do
      expect(user).to respond_to(:profile)
    end
    it "expect an user to have requested friends" do
      expect(user).to respond_to(:users_friended_by)
    end

    it "expect an user to have friend requests" do
      expect(user).to respond_to(:friended_users)
    end

    it "expect an user to have likes" do
      expect(user).to respond_to(:likes)
    end
    it "expect an user to have posts" do
      expect(user).to respond_to(:posts)
    end

    it "expect an user to have comments" do
      expect(user).to respond_to(:comments)
    end
    
  end

  # methods
  describe "methods" do 
    describe "#generate_token" do
      it "is a method" do 
         expect(user).to respond_to(:generate_token)
      end

      it "generates auth token" do
        before = user.auth_token
        user.save!
        expect(user.auth_token).to_not eq(before)
      end
    end

    describe "#regenerate_auth_token" do
      it "is a method" do 
         expect(user).to respond_to(:regenerate_auth_token)
      end

      it "generates auth token" do
        user = create(:user)
        before = user.auth_token
        user.regenerate_auth_token
        expect(user.auth_token).to_not eq(before)
      end
    end
  end
end