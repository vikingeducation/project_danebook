require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  it { is_expected.to have_secure_password }

  describe "Validations" do
    it "creates a user with valid attributes" do
      expect(user).to be_valid
    end

    it "validates password length" do
      is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(24)
    end

    it "rejects a password of invalid length" do
      naughty_user = build(:user, password: "bad!", password_confirmation: "bad!")
      expect(naughty_user).to_not be_valid
    end

    it "rejects an empty password" do
      naughty_user = build(:user, password: nil, password_confirmation: nil)
      expect(naughty_user).to_not be_valid
    end

    it "validates first name length" do
      is_expected.to validate_length_of(:first_name).is_at_least(1).is_at_most(50)
    end

    it "rejects The Man With No Name" do
      naughty_user = build(:user, first_name: nil)
      expect(naughty_user).to_not be_valid
    end

    it "validates last name length" do
      is_expected.to validate_length_of(:last_name).is_at_least(1).is_at_most(50)
    end

    it "validates email length" do
      is_expected.to validate_length_of(:email).is_at_least(1).is_at_most(50)
    end

    it "rejects email addresses that don't contain @" do
      naughty_user = build(:user, email: "bad.email.com")
      expect(naughty_user).to_not be_valid
    end

    it "rejects duplicate email addresses" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "validates college length" do
      is_expected.to validate_length_of(:college).is_at_most(50)
    end

    it "validates telephone length" do
      is_expected.to validate_length_of(:telephone).is_at_most(20)
    end

    it "validates about quote length" do
      is_expected.to validate_length_of(:quote).is_at_most(255)
    end

    it "validates about paragraph length" do
      is_expected.to validate_length_of(:about).is_at_most(1000)
    end

    it "rejects invalid dates" do
      naughty_user = build(:user, birth_date: "bad!")
      expect(naughty_user).to_not be_valid
    end

    it "won't let Terminators born in the future sign up"

  end

  describe "Associations" do
    it "has many posts" do
      is_expected.to have_many :posts
    end

    it "has many likes" do
      is_expected.to have_many :likes
    end

    it "has many comments" do
      is_expected.to have_many :comments
    end

    it "belongs to a hometown" do
      is_expected.to belong_to :hometown
    end

    it "accepts nested attributes for the hometown" do
      is_expected.to accept_nested_attributes_for :hometown
    end

    it "belongs to a current city" do
      is_expected.to belong_to :residency
    end

    it "accepts nested attributes for the current city" do
      is_expected.to accept_nested_attributes_for :residency
    end
  end

  describe "Auth tokens" do
    it "should generate an auth token on creation" do
      new_user = create(:user)
      expect(new_user.auth_token).to_not be_nil
    end

    it "should be able to #regenerate_auth_token" do
      user.save
      old_token = user.auth_token
      user.regenerate_auth_token

      expect(user.auth_token).to_not eql(old_token)
    end
  end

  describe "#name" do
    it "returns a user's full name" do
      new_user = build(:user, first_name: "Turd", last_name: "Ferguson")
      expect(new_user.name).to eql("Turd Ferguson")
    end
  end

end
