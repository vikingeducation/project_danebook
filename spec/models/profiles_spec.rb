require 'rails_helper'

describe Profile do

  let(:profile){build(:profile)}
  let(:user){build(:user)}

  it "with missing first name is invalid" do
    test_profile = build(:profile, :first_name => '')
    expect(test_profile).not_to be_valid
  end

  it "with too short last name is invalid" do
    test_profile = build(:profile, :last_name => 'D')
    expect(test_profile).not_to be_valid
  end

  it "with correct all details is valid" do
    expect(profile).to be_valid
  end

  it "with letterized telephone num is invalid" do
    test_profile = build(:profile, :telephone => '+123asd789')
    expect(test_profile).not_to be_valid
  end

  it { should validate_numericality_of(:telephone) }
  it {should validate_length_of(:about_me).is_at_most(250) }

  it "responds to the user association" do
    expect(profile).to respond_to(:user)
  end

  specify "linking nonexistent user fails" do
    profile.user_id = 1234
    expect( profile ).not_to be_valid
  end


end
