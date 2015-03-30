require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  it "is valid default out of the gate" do
    expect(user).to be_valid
  end

  describe "validations on attributes" do
    context "already have an account" do
      it "only allows one email" do
        new_user = build(:user, :email => user.email)
        expect(new_user).not_to be_valid
      end
    end
    context "wrong lengths" do
      it "hates short passwords" do 
        new_user = build(:user, :password_digest => "jll")
        expect(new_user).not_to be_valid
      end
      it "hates long passwords" do
        new_user = build(:user, :password_digest => "WHYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY")
        expect(new_user).not_to be_valid
      end
    end
  end

  describe "associations" do
    context "users and other objects" do
      it "responds to posts association" do
        expect(user).to respond_to(:posts)
      end
      it "responds to likes association" do
        expect(user).to respond_to(:likes)
      end
      it "responds to comments association" do
        expect(user).to respond_to(:comments)
      end
      it "responds to profile association" do
        expect(user).to respond_to(:profile)
      end
    end
  end
end