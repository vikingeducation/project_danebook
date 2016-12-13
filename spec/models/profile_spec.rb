require 'rails_helper'

describe Profile do

  let ( :profile ) { build(:profile) }
  describe "validations" do 
    it "only accepts people over 13" do
      profile = build(:profile, :birthday => 1.day.ago)
      expect(profile).to_not be_valid
    end
 
    it "accepts everything else" do
      expect(profile).to be_valid
    end

  end

  describe "associations" do
    it "has an user" do
      expect(profile).to respond_to(:user)
    end
  end
end
