# 1. New/Create
# a. Email address
# Requires an email address to be unique *
# Will fail without a unique email address *

# b. Password
# Cannot be created without a password *
# Password must be between 4 and 24 characters *

# c. Name
# Requires a first_name to be created *
# Requires a last name to be created *

# 3. Associations
# Creates a profile after creation *


require 'pry'
require 'rails_helper'

describe User do 

	let(:user){build(:user)}

	context "creation" do 

		it 'is valid with default attributes' do
			expect(user).to be_valid
		end

		it 'requires a unique email address' do
			expect(user).to be_valid
		end

		it "will fail without a unique email address" do
			user.save
			user1 = User.create(:first_name => "user1", 
										:email => user.email,
										:password => "123456")
			expect(user1).to be_invalid
		end

		it 'requires a password' do 
			user.password = nil
			user.password_confirmation = nil
			expect(user).to be_invalid
		end

		it 'requires a first name' do
			user.first_name = nil
			expect(user).to be_invalid
		end

		it 'requires a last name' do
			user.last_name = nil
			expect(user).to be_invalid
		end

	end

	context "password" do
		
		it 'must have at least 4 characters' do
			user.password = "1"*4
			user.password_confirmation = "1"*4
			expect(user).to be_valid
		end

		it 'cannot be under 4 characters' do
			user.password = "1"*3
			user.password_confirmation = "1"*3
			expect(user).to be_invalid
		end

		it 'must be less than 24 characters' do
			user.password = "1"*24
			user.password_confirmation = "1"*24
			expect(user).to be_valid
		end

		it 'cannot be over 24 characters' do
			user.password = "1"*25
			user.password_confirmation = "1"*25
			expect(user).to be_invalid
		end

	end
	
	context "after creation" do

		it "creates a profile object" do
			user.save
			expect(user.profile).to be_valid
		end
		
	end

	context "associations" do

	end

	context "methods" do

	end

end
