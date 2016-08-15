require 'rails_helper'

describe User do
  let(:user){build(:user)}

  describe 'validations' do
    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "saves with default attributes" do
      expect{ user.save! }.to_not raise_error
    end

    it "doesn't allow username to be nil/empty" do
      new_user = build(:user, :username => nil)
      expect(new_user.valid?).to eq(false)
    end

    it "doesn't allow email to be in the wrong format" do
      new_user = build(:user, :email => "sdfsd@.comsdf")
      expect(new_user.valid?).to eq(false)
    end

    it "doesn't allow password to be below 5 and above 25 in length" do
      new_user1 = build(:user, :password => "i" * 4)
      expect(new_user1.valid?).to eq(false)
      
      new_user2 = build(:user, :password => "i" * 26)
      expect(new_user2.valid?).to eq(false)
    end

    it "doesn't allow password to be empty/nil" do
      new_user = build(:user, :password => nil)
      expect(new_user.valid?).to eq(false)
    end

    context "when saving multiple users" do
      before do
        user.save!
      end
      it "doesn't allow identical email addresses" do
        new_user = build(:user, :email => user.email)
        expect(new_user.valid?).to eq(false)
      end

      it "doesn't allow identical usernames"  do
        new_user = build(:user, :username => user.username)
        expect(new_user.valid?).to eq(false)
      end
    end
  end

  describe 'associations' do
    it "responds to single profile association" do
      expect(user).to respond_to(:profile)
    end

    it "responds to post association" do
      expect(user).to respond_to(:posts)
    end

    it "responds to comment association" do
      expect(user).to respond_to(:comments)
    end
  end


  describe '#regenerate_auth_token by calling generate_auth_token' do
    it "generates new token for nil token user" do
      new_user = build(:user, auth_token: nil)

      expect(new_user.regenerate_auth_token).to_not eq(nil)
    end
  end
end