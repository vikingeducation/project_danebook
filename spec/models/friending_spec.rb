require 'rails_helper'

describe Friending do
  let(:user) { build(:user) }

  context 'friending users' do
    let(:friend) { build(:user) }

    it 'should allow a user to friend another' do
      user.friends << friend
      user.save
      expect(user.friends.count).to eq(1)
    end

    it 'should not allow a user to friend a user more than once' do
      user.friends << friend
      user.save
      expect{user.friends << friend}.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
