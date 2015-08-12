require 'rails_helper'
require 'support/factory_girl'

describe User do

	let(:user){build(:user)}


	it "filled fields completed is valid" do
		expect(user).to be_valid
	end

	context "associations" do

		it "should have a profile after user created" do
			user.save
			expect(user).to receive(:profile)
			user.profile
		end

		it "has one profile" do
			user.save
			new_profile = build(:profile)
			expect{user.profile << new_profile}.to raise_error
		end

    it "responds to the posts association" do
      expect(user).to respond_to(:posts)
    end

    it "responds to the likes association" do
      expect(user).to respond_to(:likes)
    end

    it "responds to the comments association" do
      expect(user).to respond_to(:comments)
    end

    it "responds to the profile association" do
      expect(user).to respond_to(:profile)
    end

		it "should has token after creation" do
			user.save
			expect(user.auth_token).to be_truthy
		end

		it "has unique token" do

			token = user.auth_token
			new_user = create(:user)
			expect(new_user.auth_token).to_not eq(token)
		end


	end

	context "email signup" do

    it "will fail with invalid email " do
      user = build(:user, email: "foobarcom")
      user.save
      expect(user).to_not be_valid
    end

    it "will fail without an email" do
     user = build(:user, email: nil)
     user.save 
     expect(user).to_not be_valid
    end

    it "will fail without a unique email" do
     user = create(:user)
     new_user = build(:user,email: "foo@bar.com" )
     expect(new_user).to_not be_valid
    end
  end 
  describe "#full_name" do

      it "is composed of first and last name" do
        expect(user.full_name).to eq("Foo Bar")

      end

  end
    it "has a first name between 3 and 15 characters" do
      user = build(:user, first_name: "")
      expect(user).to_not be_valid

      user = build(:user, first_name: "bob")
      expect(user).to be_valid
    end

    it "will fail if first name has no letters" do
      user = build(:user, first_name: "  ")
      expect(user).to_not be_valid

      user = build(:user, first_name: "11111")
      expect(user).to_not be_valid
    end 


  context "last name field" do
    it "will fail without a last name" do
      user = build(:user, last_name: nil)
      expect(user).to_not be_valid
    end

    it "has a last name between 3 and 15 characters" do
      user = build(:user, last_name: "")
      expect(user).to_not be_valid

      user = build(:user, last_name: "abc")
      expect(user).to be_valid

      user = build(:user, last_name: "Z")
      expect(user).to_not be_valid

      user = build(:user, last_name: "bobbobobobobobobobobobobobobobo")
      expect(user).to_not be_valid

      user = build(:user, last_name: "bobber")
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