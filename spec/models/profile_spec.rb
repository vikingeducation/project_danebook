require 'rails_helper'

describe Profile do

  let(:user){ create(:user) }
  let(:profile) { build(:profile) }

  it "is automatically created with a user" do
    expect(user).to respond_to(:profile)
  end

  it "is not valid when created on its own (without a user)" do
    expect(profile).not_to be_valid
  end

  it "has no required values" do
    profile = user.profile
    profile.college = nil
    profile.hometown = nil
    profile.current_home = nil
    profile.mobile = nil
    profile.summary = nil
    profile.about = nil
    expect(profile).to be_valid
  end

end