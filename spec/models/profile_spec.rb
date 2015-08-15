require 'rails_helper'

describe Profile do

  let(:profile) { build(:base_profile) }

  describe 'custom birthdate validator' do

    it 'accepts a birthdate of today' do
      profile.birthdate = Date.today
      expect(profile).to be_valid
    end

    it 'accepts a birthday of 120 years ago from today' do
      profile.birthdate = Date.today - 120.years
      expect(profile).to be_valid
    end

    it 'rejects a birthdate of tomorrow' do
      profile.birthdate = Date.tomorrow
      expect(profile).to be_invalid
    end

    it 'rejects a birthdate of 120 years ago from yesterday' do
      profile.birthdate = Date.yesterday - (120.years + 1.day)
      expect(profile).to be_invalid
    end

  end


end