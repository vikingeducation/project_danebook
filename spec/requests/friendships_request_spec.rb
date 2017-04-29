require 'rails_helper'

describe 'FriendshipsRequest' do
  let(:user){ create(:user, :with_profile)}
  let(:friend){ create(:user, :with_profile)}
  let(:send_friend_request){post user_friends_path(friend) }
  let(:friend_request_received){ create(:friendship, friender_id: friend.id, friendee_id: user.id) }

  describe 'POST #create' do
    it 'requires logged in user' do
      send_friend_request
      expect(flash[:error]).not_to be_nil
      expect(response).to redirect_to new_user_path
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
      expect(response).to redirect_to new_user_path
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
        friend_request_received
      end
      it 'updates user and friend\'s friendship status' do
        patch accept_friend_path(friend)
        records = Friendship.all
        p records
      end
    end
  end

  describe 'PATCH #reject' do
    it 'requires logged in user' do
      patch reject_friend_path(friend)
      expect(response).to redirect_to new_user_path
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)

      end
    end
  end


end
