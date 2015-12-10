require 'rails_helper'

describe Profile do
  it_behaves_like 'Dateable'
  it_behaves_like 'Feedable'

  let(:female){create(:female)}
  let(:user){create(:user, :gender => female)}
  let(:profile){user.profile}

  it 'is the only profile for the user' do
    expect(Profile.where(:user_id => user.id).count).to eq(1)
  end

  describe '#user' do
    it 'returns the user to which this profile belongs' do
      expect(profile.user).to eq(user)
    end
  end
end

