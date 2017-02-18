require 'rails_helper'

describe Profile do

  let(:user) { create(:user) }
  let(:empty_profile) { build(:profile, :empty) }

  it "belongs to a user" do
    should belong_to(:user)
  end

  it "accepts nil values" do
    user.profile = empty_profile
    expect(empty_profile).to be_valid
  end

end