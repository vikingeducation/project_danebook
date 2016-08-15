require 'rails_helper'

describe Profile do
  let(:profile){ build(:profile) }

  it "is valid with default attributes" do
    expect(profile).to be_valid
  end

  it "is invalid to have no first name" do
    bad_profile = build(:profile, first_name: "")
    expect(bad_profile).not_to be_valid
  end

  it "is invalid to have no last name" do
    bad_profile = build(:profile, last_name: "")
    expect(bad_profile).not_to be_valid
  end

  it "is invalid to have no first or last name" do
    bad_profile = build(:profile, first_name: "", last_name: "")
    expect(bad_profile).not_to be_valid
  end

  it{ should belong_to(:user).inverse_of(:profile) }

  describe "#full_name" do
    it "returns the full name" do
      expect(profile.full_name).to eq("Harry Potter")
    end
  end
end