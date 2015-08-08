require "rails_helper"

describe Profile do
  let(:profile) { build(:profile) }

  context "Validations" do

    it "is valid with attributes" do
      expect(profile).to be_valid
    end
    
  end

  context "Associations" do
    it "should respond to user" do
      expect(profile).to respond_to(:user)
    end
  end

end