require 'rails_helper'

describe FriendRequestsController do
  describe 'POST #create' do
    context 'the user is signed in' do
      context 'the user is the initiator' do
        it 'creates the friend request'
        it 'sets a success flash'
      end

      context 'the user is not the initiator' do
        it 'does not create the friend requests'
        it 'redirects to root path'
        it 'sets an error flash'
      end
    end

    context 'the user is signed out' do
      it 'redirects to signup'
      it 'sets an error flash'
    end
  end

  describe 'PUT/PATCH #update' do
    context 'the user is signed in' do
      context 'the user is the approver' do
        it 'accepts the friend request'
        it 'sets a success flash'
      end

      context 'the user is not the approver' do
        it 'does not accept the friend request'
        it 'redirects to root path'
        it 'sets an error flash'
      end
    end

    context 'the user is signed out' do
      it 'redirects to signup'
      it 'sets an error flash'
    end
  end

  describe 'DELETE #destroy' do
    context 'the user is signed in' do
      context 'the user is the initiator or the approver' do
        it 'destroys the friend request'
        it 'sets a success flash'
      end

      context 'the user is not the initiator nor the approver' do
        it 'does not destroy the friend request'
        it 'redirects to root path'
        it 'sets an error flash'
      end
    end

    context 'the user is signed out' do
      it 'redirects to signup'
      it 'sets an error flash'
    end
  end
end


