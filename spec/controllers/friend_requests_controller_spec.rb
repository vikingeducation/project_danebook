require 'rails_helper'

describe FriendRequestsController do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:friend){create(:user, :gender => male)}
  let(:other_user){create(:user, :gender => male)}
  let(:friend_request){create(:friend_request, :initiator => friend, :approver => user)}

  describe 'POST #create' do
    let(:post_create_friend_request) do
      post :create, :user_id => user.id,
                    :initiator_id => user.id,
                    :approver_id => friend.id
    end

    let(:post_create_invalid) do
      post :create, :user_id => user.id,
                    :initiator_id => friend.id,
                    :approver_id => user.id
    end

    context 'the user is signed in' do
      before do
        login(user)
      end

      context 'the user is the initiator' do
        it 'creates the friend request' do
          expect {post_create_friend_request}.to change(FriendRequest, :count).by(1)
        end

        it 'sets a success flash' do
          post_create_friend_request
          expect(flash[:success]).to_not be_nil
        end
      end

      context 'the user is not the initiator' do
        it 'does not create the friend requests' do
          expect {post_create_invalid}.to change(FriendRequest, :count).by(0)
        end

        it 'redirects to root path' do
          post_create_invalid
          expect(response).to redirect_to root_path
        end

        it 'sets an error flash' do
          post_create_invalid
          expect(flash[:error]).to_not be_nil
        end
      end
    end

    context 'the user is signed out' do
      it 'does not create the friend request' do
        expect {post_create_friend_request}.to change(FriendRequest, :count).by(0)
      end

      it 'redirects to root' do
        post_create_friend_request
        expect(response).to redirect_to root_path
      end

      it 'sets an error flash' do
        post_create_friend_request
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'PUT/PATCH #update' do
    let(:patch_update_friend_request) do
      patch :update,  :user_id => user.id,
                      :id => friend_request.id
    end

    let(:patch_update_invalid) do
      patch :update,  :user_id => user.id,
                      :id => friend_request.id
    end

    before do
      friend_request
    end

    context 'the user is signed in' do
      context 'the user is the approver' do
        before do
          login(user)
        end

        it 'creates a friendship' do
          expect {patch_update_friend_request}.to change(Friendship, :count).by(1)
        end

        it 'destroys the friend request' do
          expect {patch_update_friend_request}.to change(FriendRequest, :count).by(-1)
        end

        it 'sets a success flash' do
          patch_update_friend_request
          expect(flash[:success]).to_not be_nil
        end
      end

      context 'the user is not the approver' do
        before do
          login(friend)
        end

        it 'creates a friendship' do
          expect {patch_update_invalid}.to change(Friendship, :count).by(0)
        end

        it 'destroys the friend request' do
          expect {patch_update_invalid}.to change(FriendRequest, :count).by(0)
        end

        it 'redirects to root path' do
          patch_update_invalid
          expect(response).to redirect_to root_path
        end

        it 'sets an error flash' do
          patch_update_invalid
          expect(flash[:error]).to_not be_nil
        end
      end
    end

    context 'the user is signed out' do
      it 'redirects to root path' do
        patch_update_friend_request
        expect(response).to redirect_to root_path
      end

      it 'sets an error flash' do
        patch_update_friend_request
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_destroy_friend_request) do
      delete :destroy,  :user_id => user.id,
                        :initiator_id => user.id,
                        :approver_id => friend.id,
                        :id => friend_request.id
    end

    let(:delete_destroy_friend_request_friend) do
      delete :destroy,  :user_id => friend.id,
                        :initiator_id => user.id,
                        :approver_id => friend.id,
                        :id => friend_request.id
    end

    before do
      friend_request
    end

    context 'the user is signed in' do
      context 'the user is the initiator or the approver' do
        it 'destroys the friend request' do
          login(user)
          expect {delete_destroy_friend_request}.to change(FriendRequest, :count).by(-1)
        end

        it 'sets a success flash' do
          login(friend)
          delete_destroy_friend_request_friend
          expect(flash[:success]).to_not be_nil
        end
      end

      context 'the user is not the initiator nor the approver' do
        before do
          login(other_user)
        end

        it 'does not destroy the friend request' do
          expect {delete_destroy_friend_request}.to change(FriendRequest, :count).by(0)
        end

        it 'redirects to root path' do
          delete_destroy_friend_request
          expect(response).to redirect_to root_path
        end

        it 'sets an error flash' do
          delete_destroy_friend_request
          expect(flash[:error]).to_not be_nil
        end
      end
    end

    context 'the user is signed out' do
      it 'redirects to root path' do
        delete_destroy_friend_request
        expect(response).to redirect_to root_path
      end

      it 'sets an error flash' do
        delete_destroy_friend_request
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end





