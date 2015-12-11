require 'rails_helper'

describe Friendable do
  let(:female){create(:female)}
  let(:user){create(:user, :gender => female)}
  let(:friend){create(:user, :gender => female)}
  let(:friend_request){create(:friend_request, :initiator => user, :approver => friend)}

  describe '#initiator' do
    it 'returns the user that initiated the friendable' do
      expect(friend_request.initiator).to eq(user)
    end
  end

  describe '#approver' do
    it 'returns the user that approves the friendable' do
      expect(friend_request.approver).to eq(friend)
    end
  end

  describe 'validates' do
    describe 'user pair' do
      it 'is unique' do
        friend_request
        expect {create(:friend_request, :initiator => user, :approver => friend)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'user ids value' do
      it 'does not change on update' do
        friend_request
        fr = user.friend_requests.first
        expect {fr.update!(:initiator => friend, :approver => user)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#find_by_user' do
    it 'returns all records for the given user' do
      friend_request
      expect(FriendRequest.find_by_user(user).count).to eq(1)
    end
  end

  describe '#find_by_user_id' do
    it 'returns all records given a user id' do
      friend_request
      expect(FriendRequest.find_by_user_id(user.id).count).to eq(1)
    end
  end

  describe '#find_by_users' do
    it 'returns 1 record for the given user pair' do
      friend_request
      expect(FriendRequest.find_by_users(user, friend).count).to eq(1)
    end
  end

  describe '#find_by_user_ids' do
    it 'returns 1 record for the given user pair' do
      friend_request
      expect(FriendRequest.find_by_user_ids(user.id, friend.id).count).to eq(1)
    end
  end
end







