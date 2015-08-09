# spec/models/user_spec.rb
require 'rails_helper'

describe User do

  let(:user){ build(:user) }
  let(:saved_user){ create(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  describe "virtual attributes" do

    context "#name" do

      it "has a full name method" do
        expect(user).to respond_to(:name)
      end

      it "combines first and last name" do
        expect(user.name).to eq("#{user.first_name} #{user.last_name}")
      end

    end

  end

  describe "associations" do

    context "profile" do

      it "has a profile" do
        expect(user).to respond_to(:profile)
      end

      it "can only have one profile" do
        profile2 = build(:profile, user_id: saved_user.id)
        expect(profile2).not_to be_valid
      end

    end

  end

  describe "methods" do

    describe "#friended_by" do

      it "returns nil if a relationship doesn't exist" do
        user2 = create(:user)
        expect(user2.friended_by?(saved_user)).to be nil
      end

      it "returns a relation if the user was friended by the second user" do
        user2 = create(:user)
        create(:friending, friender_id: saved_user.id, friend_id: user2.id)
        expect(user2.friended_by?(saved_user)).to be_a(Friending)
      end
    end

  end

  describe "validations" do

    specify "first name must be present" do
      user.first_name = nil
      expect(user).not_to be_valid
    end

    specify "last name must be present" do
      user.last_name = nil
      expect(user).not_to be_valid
    end

    specify "email must be present" do
      user.email = nil
      expect(user).not_to be_valid
    end

    specify "email must be unique" do
      user.save
      user2 = build(:user, email: user.email)
      expect(user2).not_to be_valid
    end

    specify "password must be present" do
      user.password = nil
      expect(user).not_to be_valid
    end

  end


end