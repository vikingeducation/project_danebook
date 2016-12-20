require 'rails_helper'

describe User do
    let(:user){ create(:user) }

    describe "on creation" do

      it "is valid with default attributes" do
        expect(user).to be_valid
      end

      it "is invalid without an '@'" do
        invalid_user = build :user, email: "asdf"
        expect(user).to be_valid
      end

      it "is valid  without an '@'" do
        invalid_user = build :user, email: "asdf"
        expect(user).to be_valid
      end

      it "is valid with a password length greater than 5" do
        expect(user).to be_valid
      end

      it "is invalid with a password length less than 6" do
        invalid_user = build :user, password: "12345"
        expect(invalid_user).to be_invalid
      end

      it "is invalid without an unique password" do
        invalid_user = build :user, email: user.email
        expect(invalid_user).to be_invalid
      end

    end

    context "associations" do

      it "responds to its profile association" do
        expect(user).to respond_to(:profile)
      end

  end

end
