require 'rails_helper'

describe Friending do
  let(:user) { create(:user) }

  context 'friending users' do
    let(:friend) { create(:user) }

    it 'should allow a user to friend another' do
      user.friends << friend
      user.save
      expect(user.friends.count).to eq(1)
    end

    it 'should not allow a user to friend a user more than once' do
      create(:friending, user: user, friend: friend)
      expect(build(:friending, user: user, friend: friend)).to be_invalid
    end
  end
end
