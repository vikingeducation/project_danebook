require "rails_helper"

describe User do
  
  let(:user) { build(:user) }

  context "Validations" do

    it "is valid with an email, a password" do
      expect(user).to be_valid
    end

    it "is invalid without a email" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "is invalid without a password" do
      user.password = nil
      expect(user).not_to be_valid
    end

    context "Email" do
      before do
        user.save!
      end

      it "is invalid with a duplicate email address" do
        new_user = build(:user, email: user.email)
        expect(new_user).not_to be_valid
      end
    end

    context "Password" do
      it "should have length no less than 6" do
        user.password = "a" * 5
        expect(user).not_to be_valid
      end

      it "should have length no more than 20" do
        user.password = "a" * 21
        expect(user).not_to be_valid
      end

      it "should have length more than or equal to 6" do
        user.password = "a" * 6
        expect(user).to be_valid
      end

      it "should have length less than or equal to 20" do
        user.password = "a" * 20
        expect(user).to be_valid
      end
    end

  end

  context "Associations" do
    it "should respond to profile" do
      expect(user).to respond_to(:profile)
    end
    it "should respond to posts" do
      expect(user).to respond_to(:posts)
    end
    it "should respond to comments" do
      expect(user).to respond_to(:comments)
    end
    it "should respond to likes" do
      expect(user).to respond_to(:likes)
    end
  end

end