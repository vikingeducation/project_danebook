require 'rails_helper'

describe Profile do

  let(:profile){ create(:profile) }

  describe "attributes" do
    it "is valid with valid attributes" do
      expect(profile).to be_valid
    end
  end

  describe "user associations" do

    specify "linking to a valid user is a success" do
      new_user = create(:user)
      profile.user = new_user
      expect(profile).to be_valid
    end

    specify "linking to an invalid user is not successful" do
      profile.user_id = 1238
      expect(profile).not_to be_valid
    end

    it "should respond to user" do
      expect(profile).to respond_to(:user)
    end

  end

  describe "class methods" do

    it "returns users full name" do
      expect(profile.name).to eq(profile.first_name + " " + profile.last_name)
    end

  end

end
