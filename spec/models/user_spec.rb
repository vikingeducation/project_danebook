require 'rails_helper.rb'

describe User do

  let(:user) { build(:user) }

  it "is valid with a first_name, last_name, email, and password" do
    expect(user).to be_valid
  end

  it "saves with default attributes" do
    expect{ user.save! }.to_not raise_error
  end

  it "generates auth_token upon creation" do
    user.save
    expect(user.auth_token).to_not be(nil)
  end

  describe "attribute validations" do
    it "invalidates a nil first_name" do
      new_user = build(:user, first_name: nil)
      expect(new_user).to_not be_valid
    end

    it "invalidates first_name over 64 characters" do
      new_user = build(:user, first_name: "a" * 65)
      expect(new_user).to_not be_valid
    end

    it "invalidates a nil last_name" do
      new_user = build(:user, last_name: nil)
      expect(new_user).to_not be_valid
    end

    it "invalidates last_name over 64 characters" do
      new_user = build(:user, last_name: "a" * 65)
      expect(new_user).to_not be_valid
    end

    it "invalidates a nil email" do
      new_user = build(:user, email: nil)
      expect(new_user).to_not be_valid
    end

    it "invalidates an email below 3 characters" do
      new_user = build(:user, email: "a@")
      expect(new_user).to_not be_valid
    end

    it "invalidates an email without an @ character" do
      new_user = build(:user, email: "aaaa")
      expect(new_user).to_not be_valid
    end

    context "when saving multiple users" do
      before do
        user.save!
      end
      it "doesn't allow identical email addresses" do
        new_user = build(:user, :email => user.email)
        expect(new_user).not_to be_valid
      end

    end
  end

  describe "associations" do
    it "responds to the profile association" do
      expect(user).to respond_to(:profile)
    end

    it "responds to the posts association" do
      expect(user).to respond_to(:posts)
    end

    it "responds to the comments association" do
      expect(user).to respond_to(:comments)
    end

    context "friending associations" do
      let(:user_2) { build(:user) }

      it "responds to friendeds association" do
        expect(user).to respond_to(:friendeds)
      end
      it "responds to the frienders association" do
        expect(user).to respond_to(:frienders)
      end

      it "friending a valid user succeeds" do
        user.save
        user_2.save
        user.friendeds << user_2
        expect(user).to be_valid
      end

    end

  end

  describe "#name" do
    it "can be called on a user instance" do
      expect(user).to respond_to(:name)
    end

    it "returns a string" do
      expect(user.name).to be_a(String)
    end

    it "returns a user's full name" do
      expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe "#generate_token" do
    it "can be called on a user instance" do
      expect(user).to respond_to(:generate_token)
    end

    it "sets user's auth_token to a string" do
      user.generate_token
      expect(user.auth_token).to be_a(String)
    end
  end

  describe "#regenerate_auth_token" do
    it "can be called on a user instance" do
      expect(user).to respond_to(:regenerate_auth_token)
    end

    it "changes the value of the auth token" do
      old_token = user.auth_token
      user.regenerate_auth_token
      new_token = user.auth_token
      expect(old_token).to_not eq(new_token)
    end
  end

end
