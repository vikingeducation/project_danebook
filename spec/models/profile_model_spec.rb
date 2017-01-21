require 'rails_helper'

describe Profile do

  let(:profile) { build(:profile) }

  it 'saves with correct input' do
    profile.save
    expect(profile).to be_valid
  end

  it 'does not allow users to sign up with birthdays in the future' do
      profile.birth_year = 2016
      profile.save
      expect(profile).to be_invalid
  end

  it 'responds to the user association' do
    expect(profile).to respond_to(:user)
  end

  it 'succeeds when linking a real user' do
    user = create(:user)
    profile.user = user
    expect(user).to be_valid
  end

  it 'fails when linking to a fake user' do
    profile.user_id = 9999
    expect(profile).to be_invalid
  end




end