require 'rails_helper'

describe Profile do

  let(:profile) { build(:profile) }
  subject { profile }

  it { is_expected.to belong_to(:user) }

  it {
    is_expected.to validate_length_of(:first_name).
      is_at_most(50)
  }

  it {
    is_expected.to validate_length_of(:last_name).
      is_at_most(50)
  }

  it {
    is_expected.to validate_length_of(:college).
      is_at_most(50)
  }

  it {
    is_expected.to validate_length_of(:hometown).
      is_at_most(50)
  }

  it {
    is_expected.to validate_length_of(:currently_lives).
      is_at_most(50)
  }

  it {
    is_expected.to validate_length_of(:telephone).
      is_at_most(15)
  }

  it {
    is_expected.to validate_length_of(:words_to_live_by).
      is_at_most(1000)
  }

  it {
    is_expected.to validate_length_of(:about_me).
      is_at_most(1000)
  }

  it 'returns the concatenation of a users first and last name' do
    expect(profile.name).to eq('Foo Bar')
  end

  it 'does not break when one name is missing' do
    incomplete_profile = build(:profile, last_name: nil)
    expect(incomplete_profile.name).to eq('Foo')
  end

  it 'does not break when both names are missing' do
    incomplete_profile = build(:profile, last_name: nil, first_name: nil)
    expect(incomplete_profile.name).to eq(nil)
  end

  it 'does not allow future birthdays' do
    bad_profile = build(:profile, birthday: (DateTime.now + 1))
    expect(bad_profile).to_not be_valid
  end

  it 'does allow valid birthdays' do
    is_expected.to be_valid
  end
end
