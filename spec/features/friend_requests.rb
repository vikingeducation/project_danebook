require 'rails_helper'

describe 'FriendRequests' do
  describe 'listing' do
    it 'displays all pending friend requests in a dropdown'
  end

  describe 'accepting' do
    it 'results in the friend request being removed'
    it 'results in a friendship being created'
  end

  describe 'rejecting' do
    it 'results in the friend request being removed'
  end
end