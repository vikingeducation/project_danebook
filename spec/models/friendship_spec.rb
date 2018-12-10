require 'rails_helper'

RSpec.describe Friendship, type: :model do

  let(:new_friendship){ create(:friendship) }

  describe 'attributes' do
    it 'with valid users is valid' do
      expect(new_friendship).to be_valid
    end

    it 'is valid when linking a valid user' do
      another_user = create(:user)
      expect(create(:friendship, friendee_id: another_user.id)).to be_valid
    end

    it 'is invalid when linking an invalid user' do
      new_friendship.friendee_id = 12
      expect(new_friendship).not_to be_valid
    end
  end

  describe 'associations' do
    it 'responds to friendee' do
      expect(new_friendship).to respond_to(:friendee)
    end

    it 'responds to friender' do
      expect(new_friendship).to respond_to(:friender)
    end
  end
  
end
