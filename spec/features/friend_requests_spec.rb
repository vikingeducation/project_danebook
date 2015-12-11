require 'rails_helper'

describe 'FriendRequests' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:friend){create(:user, :gender => male)}
  let(:friend_request){create(:friend_request, :initiator => friend, :approver => user)}

  before do
    friend_request
    visit login_path
    sign_in(user)
    visit user_friendships_path(user)
  end

  describe 'listing' do
    it 'displays all pending friend requests' do
      expect(page).to have_content('Accept Reject')
    end
  end

  describe 'accepting' do
    it 'results in the friend request being removed' do
      expect {click_link('Accept')}.to change(FriendRequest, :count).by(-1)
    end

    it 'results in a friendship being created' do
      expect {click_link('Accept')}.to change(Friendship, :count).by(1)
    end
  end

  describe 'rejecting' do
    it 'results in the friend request being removed' do
      expect {click_link('Reject')}.to change(FriendRequest, :count).by(-1)
    end
  end
end


