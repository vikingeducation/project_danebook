require 'rails_helper'

describe FriendRequest do
  describe '#initiator' do
    it 'returns the user who initiated the friend request'
  end

  describe '#approver' do
    it 'returns the user who approves the friend request'
  end

  describe '#accept' do
    it 'triggers a after update callback'
    it 'results in a friendship being created when set to true'
    it 'results in no friendship being created if set to false'
  end
end

# TODO
#   test Dateable
#   test Friendable
#   test Notifiable
