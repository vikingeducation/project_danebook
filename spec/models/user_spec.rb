require 'rails_helper'

describe User do

  let(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:password) }

    it 'password length is between 6 and 24 inclusive' do
      is_expected.to validate_length_of(:password).
        is_at_least(6).is_at_most(24)
    end

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:email) }

    it { is_expected.to allow_value('admin@example.com').for(:email) }

    it { is_expected.to_not allow_value('noatsymbolhere').for(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_one(:profile).inverse_of(:user) }
    it { is_expected.to have_secure_password }
    it { is_expected.to have_many(:frienders) }
    it { is_expected.to have_many(:friendees) }
  end

  describe 'model methods' do

    let(:user) { create(:user) }
    let(:otheruser) { create(:user) }
    let(:randomuser) { create(:user) }
    before do
      user
      otheruser
      randomuser
      create(:friending, friending_initiator: user, friending_recipient: otheruser)
    end

    it 'user generates a token on creation' do
      expect(user.auth_token).to_not be_nil
    end

    it 'regenerate_auth_token generates a unique token and resaves user' do
      auth_token = user.auth_token
      user.regenerate_auth_token

      expect(user.auth_token).to_not equal(auth_token)
    end

    it 'friends method returns all of frienders and friendees of the user' do
      expect(user.friends).to match_array([otheruser])
    end

    it 'friends_with? returns true if user is friends with otheruser' do
      expect(user.friends_with?(otheruser)).to be true
    end

    it 'friends_with? returns false if user is not friends with otheruser' do
      expect(user.friends_with?(randomuser)).to be false
    end

  end

end
