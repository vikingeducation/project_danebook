require 'rails_helper'
require 'support/factory_girl'

describe User do

  let(:user){build(:user)}


  it "with all fields completed is valid" do
    expect(user).to be_valid
  end

  it "saves without error" do
    expect{user.save!}.to_not raise_error
  end


  context "birthdate" do

    it "cannot be nil" do
      user = build(:user, birthdate: nil)
      expect(user).to_not be_valid
    end

    #need to add date validations for this
    xit "will raise error if birthdate is not a date" do
      user = build(:user, birthdate: "password")
      expect{user.birthdate}.to raise_error
    end
  end

  context "associations" do

    it "should have a profile after user created" do
      user.save
      expect(user).to receive(:profile)
      user.profile
    end

    it "cannot have more than one profile" do
      # user.profile = create_list(:profile, 2)
      # expect{user.save}.to raise_error
      user.save
      new_profile = build(:profile)
      expect{user.profile << new_profile}.to raise_error
    end

    it "should have a token after creation" do
      user.save
      expect(user.auth_token).to be_truthy
    end

    it "cannot have the same token as another user" do
      user.save
      token = user.auth_token
      new_user = build(:user, auth_token: token)
      new_user.save
      expect(new_user.auth_token).to_not eq(token)
    end

    it "can have many posts" do
      user.posts = create_list(:post, 5)
      user.save
      expect(user.posts.count).to eq(5)
    end
  end

  context "email field" do

    it "will fail without an email" do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it "will fail without a unique email" do
      user = build(:user, email: "foo@bar.com")
      user.save

      new_user = build(:user, first_name: "foo", last_name: "bar",
                        email: "foo@bar.com", password: "password",
                        password_confirmation: "password",
                        birthdate: Date.parse('20-10-2000') )

      expect(new_user).to_not be_valid

    end

    it "will fail if email input doesn't have '@'" do
      user = build(:user, email: "foo.bar.com")
      expect(user).to_not be_valid
    end
  end

  context "first name field" do

    it "will fail without a first name" do
      user = build(:user, first_name: nil)
      expect(user).to_not be_valid
    end

    it "has a first name between 1 and 30 characters" do
      user = build(:user, first_name: "")
      expect(user).to_not be_valid

      user = build(:user, first_name: "A")
      expect(user).to be_valid

      str= "foobarbaz"*4
      user = build(:user, first_name: str)
      expect(user).to_not be_valid

      str= "foobarbaz"*3
      user = build(:user, first_name: str)
      expect(user).to be_valid
    end

    it "will fail if first_name has no letters" do
      user = build(:user, first_name: "  ")
      expect(user).to_not be_valid

      user = build(:user, first_name: "1238")
      expect(user).to_not be_valid
    end
  end

  context "last name field" do
    it "will fail without a last name" do
      user = build(:user, last_name: nil)
      expect(user).to_not be_valid
    end

    it "has a last name between 1 and 30 characters" do
      user = build(:user, last_name: "")
      expect(user).to_not be_valid

      user = build(:user, last_name: "A")
      expect(user).to be_valid

      str= "foobarbaz"*4
      user = build(:user, last_name: str)
      expect(user).to_not be_valid

      str= "foobarbaz"*3
      user = build(:user, last_name: str)
      expect(user).to be_valid
    end

    it "will fail if last_name has no letters" do
      user = build(:user, last_name: "  ")
      expect(user).to_not be_valid

      user = build(:user, last_name: "1238")
      expect(user).to_not be_valid
    end
  end


  context "password" do

    it "password length between 8 and 25 characters are valid" do

      expect(user).to be_valid

      user = build(:user, password: "12345jkl",
                  password_confirmation: "12345jkl")
      expect(user).to be_valid
    end

    it "password length not in 8-25 character range are invalid" do
      user = build(:user, password: "12345jk",
                  password_confirmation: "12345jk")
      expect(user).to_not be_valid

      str= "password1"*3
      user = build(:user, password: str, password_confirmation: str)
      expect(user).to_not be_valid
    end

    it "should have matching password and password confirmation" do

      expect(user).to be_valid

      user = build(:user, password: "password", password_confirmation: "password1")

      expect(user).to_not be_valid
    end

  end



  context "instance methods" do
    it "should respond to full_name method" do
      expect{user.full_name}.to_not raise_error
    end
  end






end