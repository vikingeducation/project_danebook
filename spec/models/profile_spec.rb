require 'rails_helper'

describe Profile do
  let(:user){ create(:user) }
  let(:profile){ build(:profile, :user_id => user.id) }

  describe 'validations' do
    it 'default profile is valid' do
      profile.save
      expect(profile).to be_valid
    end

    it 'user should be unique' do
      should validate_uniqueness_of(:user_id)
    end

    it 'user is present' do
      should validate_presence_of(:user_id)
    end

    it 'invalid when user not present' do
      invalid_profile = build(:profile, :user_id => nil)
      expect(invalid_profile).not_to be_valid
    end

    it { should validate_length_of(:college).is_at_least(1).is_at_most(50) }
    it { should validate_length_of(:hometown).is_at_least(1).is_at_most(50) }
    it { should validate_length_of(:current_location).is_at_least(1).is_at_most(50) }
    it { should validate_length_of(:telephone).is_at_least(10).is_at_most(11) }
    it {should validate_length_of(:words).is_at_least(1).is_at_most(300) }
    it {should validate_length_of(:about_me).is_at_least(1).is_at_most(300) }

  end

  describe 'associations' do
    before do
      profile.save
    end

    it { should belong_to(:user) }

    it 'dependent on user' do
      expect{ user.destroy }.to change{ Profile.count }.by(-1)
    end
  end

end