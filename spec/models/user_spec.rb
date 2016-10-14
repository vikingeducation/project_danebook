require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with default attributes" do
    user = build(:user)
    expect{user.save!}.not_to raise_error
  end
  it { should have_many(:posts)}
  it { should have_many(:initiated_likes) }
  it { should have_many(:authored_comments) }
  it { should validate_presence_of(:first_name) }

end

describe User do
  describe "general" do
    let(:user){ build(:user) }
    it "is valid with default attributes" do
      expect(user).to be_valid
    end
    it "default user can be saved" do
      user = create(:user)
      expect(user.persisted?).to be_truthy
    end
    it "default unsaved user is not present int the DB" do
      expect(user.persisted?).to be_falsey
    end
    it "check presence of name" do
      should validate_presence_of(:first_name)
      should validate_presence_of(:last_name)
    end
    it "check presence of email" do
      should validate_presence_of(:email)
    end
    it "has_secured_pw" do
      should have_secure_password
    end
    it "create a user in db and verify name" do
      user = create(:user, name: "Foo Bar")
      expect(user.name).to eq("Foo Bar")
    end
    it "create a user in db and verify email" do
      user = create(:user, :name => "foobar", :password => "123foobar")
      expect(user.email).to eq("foo@bar.com")
    end
  end

  describe "validations" do
    it "without first_name is not valid" do
      new_user = build(:user, :first_name => nil)
      expect(new_user).not_to be_valid
    end
    it "without last_name is not valid" do
      new_user = build(:user, :last_name => nil)
      expect(new_user).not_to be_valid
    end
    it "email should be unique" do
      user = create(:user)
      new_user = build(:user, :name => "Zoo boo")
      expect(new_user).to be_invalid
    end
    it "with password length 7 is invalid" do
      user = build(:user, :password => "1"*7)
      expect(user).not_to be_valid
    end
    it "with password length 8 is valid" do
      user = build(:user, :password => "1"*8)
      expect(user).to be_valid
    end
    it "with password length 25 is invalid" do
      user = build(:user, :password => "1"*25)
      expect(user).not_to be_valid
    end
    it "with password length 24 is valid" do
      user = build(:user, :password => "1"*24)
      expect(user).to be_valid
    end
  end

  describe "associations" do
    let(:user){ build(:user) }
    let(:profile){ build(:profile) }
    it "has 1 profile" do
      expect(user).to respond_to(:profile)
    end
    it "user profile is nil by default" do
      expect(user.profile).to eq(nil)
    end
    it "user profile set" do
      user = create(:user)
      profile = Profile.new(college: "New College")
      user.profile = profile
      user.save!
      user.reload
      expect(user.profile).to eq(profile)
    end
    it "responds_to posts" do
      expect(user).to respond_to(:posts)
    end
    it "responds_to authored_comment" do
      expect(user).to respond_to(:authored_comments)
    end
    it "responds_to initiated_likes" do
      expect(user).to respond_to(:initiated_likes)
    end
  end
end