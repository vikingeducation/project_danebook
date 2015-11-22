require 'rails_helper'

describe Profile do
  let(:female){create(:female)}
  let(:user){create(:user, :gender => female)}
  let(:profile){create(:profile, :user => user)}

  describe '#user' do
    it 'returns the user to which this profile belongs' do
      expect(profile.user).to eq(user)
    end
  end
end

