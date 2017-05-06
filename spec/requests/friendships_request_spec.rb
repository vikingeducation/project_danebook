require 'rails_helper'

describe 'FriendshipsRequest', type: :request do
  let(:user){ create(:user, :with_profile)}
  let(:friend){ create(:user, :with_profile)}
  let(:send_friend_request){post user_friends_path(friend) }
  let(:friend_request_received){ create(:friendship, friender_id: friend.id, friendee_id: user.id) }
  let(:friend_request_sent){ create(:friendship, friender_id: user.id, friendee_id: friend.id)}

  describe 'POST #create' do
    it 'requires logged in user' do
      send_friend_request
      expect(flash[:error]).not_to be_nil
      expect(response).to redirect_to new_user_session_path
    end

    context 'logged in' do

      before do
        login_as(user, scope: :user)
        send_friend_request
      end

      it 'sends a friend invite' do
        expect(flash[:success]).not_to be_nil
      end
      it 'redirects to friend profile' do
        expect(response).to redirect_to user_profile_path(friend)
      end
    end
  end

  describe 'PATCH #accept' do
    it 'requires logged in user' do
      patch accept_friend_path(friend)
      expect(response).to redirect_to new_user_session_path
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
        friend_request_received
      end
      it 'updates user and friend\'s friendship status' do
        expect{ patch accept_friend_path(friend) }.to change(Friendship, :count).by(1)
        expect(Friendship.first.rejected).to be false
        expect(Friendship.second.rejected).to be false
      end
      it 'updates a user\'s friend count' do
        patch accept_friend_path(friend)
        user.reload
        expect(user.friendships_count).to eq(1)
      end
    end
  end

  describe 'PATCH #reject' do
    it 'requires logged in user' do
      patch reject_friend_path(friend)
      expect(response).to redirect_to new_user_session_path
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
        friend_request_received
      end
      it 'rejects a friend request' do
        expect{ patch reject_friend_path(friend)}.not_to change(Friendship, :count)
        expect(Friendship.first.rejected).to be true
      end
    end
  end

  describe 'PATCH #cancel' do
    it 'requires logged in user' do
      friend_request_sent
      patch cancel_friend_path(friend)
      expect(response).to redirect_to new_user_session_path
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
        friend_request_sent
      end
      it 'cancels a friend request' do
        expect{ patch cancel_friend_path(friend) }.to change(Friendship, :count).by(-1)
      end
    end
  end



end
