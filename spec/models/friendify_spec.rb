require 'rails_helper'

describe Friendify do

  let(:friendify){ Friendify }
  let(:user){build(:user)}
  let(:friend){build(:user)}

  before do
    user.save
    friend.save
  end

  describe '.friendship' do

    it "processes a new friend request and returns a status message" do
      expect(friendify.friendship(user, friend)[0]).to eq(:success)
      expect(friend.friend_requests.length).to be > 0
    end

    it "rejects an already sent friend request and returns a status message" do
      friendify.friendship(user, friend)
      requests = friend.friend_requests.length
      expect(friendify.friendship(user, friend)[0]).to eq(:danger)
      expect(friend.friend_requests.length).to eq(requests)
    end

    it "rejects a self friend request and returns a status message" do
      requests = user.friend_requests.length
      expect(friendify.friendship(user, user)[0]).to eq(:danger)
      expect(user.friend_requests.length).to eq(requests)
    end

    it "creates a friendship when a friend request is reciprocated and returns a status message" do
      friends = user.friends.size
      friendify.friendship(user, friend)
      expect(friendify.friendship(friend, user)[0]).to eq(:success)
      expect(user.friends.size).to be > friends
      expect(friend.friends).to include(user)
    end

    it "rejects friend request if users are already friends and returns a status message" do
      friendify.friendship(user, friend)
      friendify.friendship(friend, user)
      friends = user.friends.size
      expect(friendify.friendship(user, friend)[0]).to eq(:danger)
      expect(user.friends.size).to eq(friends)
    end

  end

  describe '.clear_request' do

    it "cancels a friend request and returns a status message" do
      friendify.friendship(user, friend)
      requests = friend.friend_requests.length
      friendify.clear_request(user, friend)
      friend.reload
      expect(friend.friend_requests.length).to be < requests
    end

  end

end
