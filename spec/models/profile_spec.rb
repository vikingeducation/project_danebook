require 'rails_helper'

describe Profile, type: :model do

  let(:profile) { build(:profile) }

  it 'with valid default attributes is valid' do
    expect(profile).to be_valid
  end

  it 'with blank college is valid' do
    new_profile = build(:profile, college: nil)
    expect(new_profile).to be_valid
  end

  it 'with blank hometown is valid' do
    new_profile = build(:profile, hometown: nil)
    expect(new_profile).to be_valid
  end

  it 'with blank currently_lives is valid' do
    new_profile = build(:profile, currently_lives: nil)
    expect(new_profile).to be_valid
  end

  it 'with blank telephone is invalid' do
    new_profile = build(:profile, telephone: nil)
    expect(new_profile).not_to be_valid
  end

  context 'check validations are accurate' do
    it 'with invalid telephone entry is invalid' do
      new_profile = build(:profile, telephone: "10010010010000101"*10)
      expect(new_profile).not_to be_valid
    end

    it 'with invalid telephone entry is invalid' do
      new_profile = build(:profile, telephone: "500")
      expect(new_profile).not_to be_valid
    end

    it 'with valid telephone entry is valid' do
      new_profile = build(:profile, telephone: "6362931540")
      expect(new_profile).to be_valid
    end

    it { should validate_length_of(:words_to_live_by).is_at_most(255) }

    it { should validate_length_of(:about_me).is_at_most(1000) }

    it { should validate_length_of(:college).is_at_most(64) }

    it { should validate_length_of(:hometown).is_at_most(64) }

    it { should validate_length_of(:currently_lives).is_at_most(64) }
  end

  context 'validates uniqueness of profile to user' do
    let(:user) { build(:user) }

    it 'will be valid for user with 1 profile' do
      user.profile = profile
      expect(user).to be_valid
    end

    it 'will set user_id of profile to user inheriting profile' do
      user.profile = profile
      expect(profile.user_id).to be(user.id)
    end
  end
end
