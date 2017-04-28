require 'rails_helper'

describe Friendship do
  let(:user){ create(:user)}

  context 'validations' do
    it 'raises error if friendship already exists' do
      friend = create(:user)
      expect{user.friendee_ids = ([friend.id, friend.id])}.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'does not raise error if friendship doesn\'t already exist' do
      friend = create(:user)
      expect{user.friendee_ids = [friend.id]}.not_to raise_error
    end
    it 'raises error if user tries to friend self' do
      expect{user.friendee_ids = [user.id]}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end


end
