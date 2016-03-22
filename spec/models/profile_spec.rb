require 'rails_helper'

describe Profile do

  let(:profile) { build(:profile) }
  let(:user) { create(:user) }
  
  describe "attributes" do

    it "is valid with default attributes" do
      expect(profile).to be_valid
    end

    it "is saves with valid attributes" do
      expect { profile.save! }.to_not raise_error
    end

  end

  describe "associations" do

    it "responds to user" do
      expect(profile).to respond_to(:user)
    end

    context "on setting User for profile" do

      it "is valid when saving (valid) User" do
        profile.user = user
        expect(profile).to be_valid
      end

      it "is not valid when saving to a nonexistent User" do
        profile.user_id = 12345
        expect(profile).to_not be_valid
      end

    end
  end


end