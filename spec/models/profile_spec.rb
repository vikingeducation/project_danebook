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


  describe 'Profile.search' do

    before do
      # Profile.import
      create_list(:full_profile, 2,
                  :first_name => 'Good',
                  :last_name => 'Result')
      create( :full_profile,
              :first_name => 'Bad',
              :last_name => 'Result')
    end

    it 'returns results based on first name' do
      response = Profile.search('Good')
      expect(response.size).to eq(2)
    end

    it 'returns results based on last name' do
      response = Profile.search('Result')
      expect(response.size).to eq(3)
    end

    it 'is case insensitive' do
      response = Profile.search('reSUlt')
      expect(response.size).to eq(3)
    end

    it 'returns 0 for no matches' do
      response = Profile.search('Mismatch')
      expect(response.size).to eq(0)
    end

    it 'returns all for no parameters' do
      response = Profile.search('')
      expect(response.size).to eq(Profile.all.count)
    end

  end



end