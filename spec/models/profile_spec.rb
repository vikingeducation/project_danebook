require 'rails_helper'

describe Profile do
  let (:user){ FactoryGirl.build(:user)}

  it 'is valid with day, month, year and gender fields filled in' do
    expect(user.profile).to be_valid
  end

  it 'is invalid without a day' do
    expect(FactoryGirl.build(:profile, day: nil)).not_to be_valid
  end

  it 'is invalid without a month' do
    expect(FactoryGirl.build(:profile, month: nil)).not_to be_valid
  end

  it 'is invalid without a year' do
    expect(FactoryGirl.build(:profile, year: nil)).not_to be_valid
  end

  it 'is invalid without a gender' do
    expect(FactoryGirl.build(:profile, gender: nil)).not_to be_valid
  end

end