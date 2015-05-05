require 'rails_helper'

describe Profile do
  let (:user){ FactoryGirl.build(:user)}

  it 'is valid with day, month, year and gender fields filled in and the rest blank' do
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

  it 'is valid if college name length is 25 or less' do
    user.profile.college = "ABCDEFGHIJKLMNOPQRSTUVWXY"
    expect(user.profile).to be_valid
  end

  it 'is invalid if college name length is greater than 25' do
    user.profile.college = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    expect(user.profile).not_to be_valid
  end


  it 'is valid if hometown name length is 35 or less' do
    user.profile.hometown = "A" * 35
    expect(user.profile).to be_valid
  end

  it 'is invalid if hometown name length is greater than 35' do
    user.profile.hometown = "A" * 36
    expect(user.profile).not_to be_valid
  end


  it 'is invalid if currently_lives length is greater than 35' do
    user.profile.hometown = "A" * 36
    expect(user.profile).not_to be_valid
  end

  it 'is valid if currently_lives length is 35 or less' do
    user.profile.hometown = "A" * 35
    expect(user.profile).to be_valid
  end


  it 'is invalid if telephone number length is greater than 25' do
    user.profile.telephone = "1" * 26
    expect(user.profile).not_to be_valid
  end

  it 'is valid if telephone number length is 25 or less' do
    user.profile.telephone = "1" * 25
    expect(user.profile).to be_valid
  end

  it 'is invalid if "words to live by" is longer than 140 characters' do
    user.profile.words_to_live_by = "A" * 141
    expect(user.profile).not_to be_valid
  end

  it 'is valid if "words to live by" is 140 characters or less' do
    user.profile.words_to_live_by = "A" * 140
    expect(user.profile).to be_valid
  end

  it 'is invalid if "about me" is longer than 400 characters' do
      user.profile.hometown = "A" * 401
      expect(user.profile).not_to be_valid
  end

  it 'is valid if "about me" is 400 characters or less' do
      user.profile.hometown = "A" * 401
      expect(user.profile).not_to be_valid
  end


  describe '#birthday' do
    it 'should concatenate the user\'s birthday' do
      expect(user.profile.birthday).to eq("#{user.profile.month}\/#{user.profile.day}\/#{user.profile.year}")
    end
  end

  describe '#birthday=' do
    it "takes a date string and changes the components in the model" do
      user.profile.birthday = "2/28/1982"
      expect(user.profile.day).to eq(28)
      expect(user.profile.month).to eq(2)
      expect(user.profile.year).to eq(1982)
    end
  end

end