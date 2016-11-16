require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  it { is_expected.to have_secure_password } 

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  describe "attribute validations" do 

    it "doesn't allow passwords that are too short" do
      user = build(:user, password: "123")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "doesn't allow passwords that are too long" do
      user = build(:user, password: "1234567891011121314151617181920s")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "allows edge case passwords" do
      user = build(:user, password: "This password is 24 char")
      expect{ user.save! }.to_not raise_error
    end

    it "validates email format" do
      user = build(:user, email: "email.com")
      expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    context "when saving multiple users" do
      before do
        user.save!
      end
      it "doesn't allow identical email addresses" do
        new_user = build(:user, :email => user.email)
        expect{ new_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "associations" do 
    it "responds to the posts association" do
      expect(user).to respond_to(:posts)
    end

    it "responds to the likes association" do
      expect(user).to respond_to(:likes)
    end

    it "responds to the comments association" do
      expect(user).to respond_to(:comments)
    end
  end

end