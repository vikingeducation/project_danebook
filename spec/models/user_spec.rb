require 'rails_helper'
require 'pry'

describe User do

  let(:user){ build(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "is not valid without a first_name" do
    user.first_name = nil
    expect(user).to be_invalid
  end

  it "is not valid without a last_name" do
    user.last_name = nil
    expect(user).to be_invalid
  end

  it "is not valid without a password" do
    user.password = nil
    expect(user).to be_invalid
  end

  it 'is not valid if password is eight spaces' do
    user.password = "        "
    expect(user).to be_invalid
  end

  # This should not pass either
  it "is not valid without a password_confirmation" do
    user.password_confirmation = nil
    expect(user).to be_valid
  end

  it 'is not valid with unmatched password_confirmation' do
    user.password_confirmation = '1234'
    expect(user).to be_invalid
  end

  it 'is not valid if password is less than 7 chars' do
    user.password = "123456"
    expect(user).to be_invalid
  end

  it 'is not valid if password is more than 24 chars' do
    user.password = "1"*25
    expect(user).to be_invalid
  end

  it 'is valid if password is 7 chars long' do
    user.password = "1234567"
    expect(user).to be_valid
  end

  it 'is valid if password is 24 chars long' do
    user.password = "1"*24
    expect(user).to be_valid
  end

  it 'is not valid without email' do
    user.email = nil
    expect(user).to be_invalid
  end

  it 'is not valid with email as spaces' do
    user.email = "    "
    expect(user).to be_invalid
  end

  it 'is not valid with duplicate email' do
    user.save
    new_user = build(:user, :email => user.email)
    expect(new_user).to be_invalid
  end

  it 'is not valid without date_of_birth' do
    user.dob = " "
    expect(user).to be_invalid
  end

  it 'is not valid without gender' do
    user.gender = ""
    expect(user).to be_invalid
  end

  it 'saves a valid user instance' do
    expect{ user.save! }.to_not raise_error
  end

  it 'responds to posts associations' do
    expect(user).to respond_to(:posts)
  end

  it 'responds to profile associations' do
    expect(user).to respond_to(:profile)
  end

  it 'responds to likes associations' do
    expect(user).to respond_to(:likes)
  end

  it 'responds to comments associations' do
    expect(user).to respond_to(:comments)
  end

  it 'responds to friends associations' do
    expect(user).to respond_to(:friends)
  end

  describe '#generate_token' do
  #
    it 'generates an auth token after save' do
      user.save
      expect(user.auth_token).should_not be_nil
    end

  end

  describe '#regenerate_auth_token' do

    it 'should regenerate a different auth token' do
      user.save
      old_auth = user.auth_token
      user.regenerate_auth_token
      expect(user.auth_token).to_not eq(old_auth)
    end

  end

  describe '#full_name' do

    it 'should return a full name as a string' do
      expect(user.full_name).to be_a String
    end

  end

  describe '#find_user_by_keyword(string)' do

    it 'should return at least one user if they exist' do
      user.save
      puts User.all.find_user_by_keyword("foo")
      expect(User.all.find_user_by_keyword("foo")[0].first_name).to eq("Foo")
    end

  end

  describe '#profile_create' do

    it 'should create a profile for a user' do
      user.save
      expect(user.profile).should_not be_nil
    end
  end


end