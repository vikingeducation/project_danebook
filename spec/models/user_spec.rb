require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  it "validates the presence of an email address" do
    should validate_presence_of(:email)
  end

  it "validates the uniqueness of an email address" do
    should validate_uniqueness_of(:email)
  end

  it "validates the presence of a password" do
    should validate_presence_of(:password)
  end

  it "accepts a password with a length that has at least 6 characters" do
    should validate_length_of(:password).is_at_least(6)
  end

  it "accepts a password with a length that has at most 40 characters" do
    should validate_length_of(:password).is_at_most(40)
  end

  it "has a secure password" do
    is_expected.to have_secure_password
  end

  it "has a profile" do
    expect(user).to have_one(:profile)
  end

  it "has friends" do
    expect(user).to have_many(:friends)
  end

  it "belongs to a friendable" do
    expect(user).to belong_to(:friendable)
  end

  it "belongs to a timeline" do
    expect(user).to belong_to(:timeline)
  end

  it "has a first name" do
    expect(user).to respond_to(:first_name)
  end

  it "has a last name" do
    expect(user).to respond_to(:last_name)
  end

  it "can show its full name" do
    first_name = user.first_name
    last_name = user.last_name
    full_name = "#{first_name} #{last_name}"
    expect(user.full_name).to eq(full_name)
  end

  it "has many posts" do
    expect(user).to have_many(:posts)
  end

  it "has many comments" do
    expect(user).to have_many(:comments)
  end

  it "has many likes" do
    expect(user).to have_many(:likes)
  end

  describe "#friend?" do
    it "returns false when a user is not a friend of another user" do
      other_user = build(:user)
      expect(user.friend?(other_user)).to eq(false)
    end

    it "returns true when a user is a friend of another user" do
      user.id = 1
      other_user = user.friends.build
      expect(other_user.friend?(user)).to eq(true)
    end

  end

end