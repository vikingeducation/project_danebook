require 'rails_helper'

describe FriendshipsController do
  describe 'GET #index' do
    context 'the user is signed in' do
      it 'sets an instance variable to all the friends of the user'
      it 'sets an instance variable to the user'
    end

    context 'the user is signed out' do
      it 'redirects to the root path'
      it 'sets an error flash'
    end
  end

  describe '#DELETE destroy' do
    context 'the user is signed in' do
      context 'the user is the initiator or approver' do
        it 'destroys the friendship'
        it 'sets a success flash'
      end

      context 'the user is not the initiator nor approver' do
        it 'does not destroy the friendship'
        it 'redirects to root path'
        it 'sets an error flash'
      end
    end

    context 'the user is signed out' do
      it 'redirects to root path'
      it 'sets an error flash'
    end
  end
end


