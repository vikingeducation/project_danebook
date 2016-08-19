require 'rails_helper'

describe Profile do

  let(:profile){ build(:profile, :with_attributes) }

  it "is valid with default attributes" do
    expect(profile).to be_valid
  end

  it "is invalid without default attributes" do
    new_profile = build_stubbed(:profile)
    expect(new_profile).to_not be_valid
  end

  it "has first_name between 2 and 40 characters" do
    should validate_length_of(:first_name).is_at_least(2).is_at_most(40)
  end

  it "has last_name between 2 and 40 characters" do
    should validate_length_of(:last_name).is_at_least(2).is_at_most(40)
  end

  it "responds to user association" do
    expect(profile).to respond_to(:user)
  end

  it "checks the method name to create the profile full name" do
    expect(profile.name).to eq("foo bar")
  end

end