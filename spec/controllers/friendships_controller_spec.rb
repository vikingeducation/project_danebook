require 'rails_helper'

describe FriendshipsController do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:friend){create(:user, :gender => male)}
  let(:other_user){create(:user, :gender => male)}
  let(:friend_request){create(:friend_request, :initiator => friend, :approver => user)}

  before do
    friend_request.accept
  end

  describe 'GET #index' do
    context 'the user is signed in' do
      before do
        login(user)
        get :index, :user_id => user.id
      end

      it 'sets an instance variable to all the friends of the user' do
        expect(assigns(:friends)).to eq(user.friends)
      end

      it 'sets an instance variable to the user' do
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'the user is signed out' do
      before do
        get :index, :user_id => user.id
      end

      it 'redirects to the signup path' do
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe '#DELETE destroy' do
    let(:delete_destroy_friendship) do
      delete :destroy,  :user_id => user.id,
                        :initiator_id => user.id,
                        :approver_id => friend.id,
                        :id => friend_request.id
    end

    let(:delete_destroy_friendship_friend) do
      delete :destroy,  :user_id => friend.id,
                        :initiator_id => user.id,
                        :approver_id => friend.id,
                        :id => friend_request.id
    end

    before do
      friend_request.accept
    end

    context 'the user is signed in' do
      context 'the user is the initiator or approver' do
        it 'destroys the friendship' do
          login(user)
          expect {delete_destroy_friendship}.to change(Friendship, :count).by(-1)
        end

        it 'sets a success flash' do
          login(friend)
          delete_destroy_friendship_friend
          expect(flash[:success]).to_not be_nil
        end
      end

      context 'the user is not the initiator nor approver' do
        before do
          login(other_user)
        end

        it 'does not destroy the friendship' do
          expect {delete_destroy_friendship}.to change(Friendship, :count).by(0)
        end

        it 'redirects to root path' do
          delete_destroy_friendship
          expect(response).to redirect_to root_path
        end

        it 'sets an error flash' do
          delete_destroy_friendship
          expect(flash[:error]).to_not be_nil
        end
      end
    end

    context 'the user is signed out' do
      it 'redirects to signup path' do
        delete_destroy_friendship
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        delete_destroy_friendship
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end










