require 'rails_helper'

describe FriendRequest do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:friend){create(:user, :gender => male)}
  let(:friend_request){create(:friend_request, :initiator => user, :approver => friend)}

  describe '#accept' do
    it 'results in a friendship being created' do
      expect {friend_request.accept}.to change(Friendship, :count).by(1)
    end

    it 'results in the friend request being destroyed' do
      friend_request
      expect {friend_request.accept}.to change(FriendRequest, :count).by(-1)
    end
  end
end
