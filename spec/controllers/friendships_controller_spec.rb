require 'rails_helper'

describe FriendshipsController do

  let(:user)  { create(:user) }
  let(:user2) { create(:user) }
  let(:friendship){ build(:friendship) }

  before do
    controller_sign_in
    @request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'
  end

  context 'RESTful friendship actions' do

    describe 'GET #index' do

      xit 'sends all friends of page owner' do
        create(:friendship,
                initiator_id: user.id,
                acceptor_id: user2.id)
        get :index, :user_id => user.id
        expect(response).to include(user2)
      end

    end

    describe 'POST #create' do

      it 'sends friend request if not already friends' do
        expect do
          post  :create,
                user_id: user.id,
                friendship: attributes_for(:friendship)
        end.to change(Friendship, :count).by(1)
      end

      it 'does not send friend request if already requested' do
        expect do
          post  :create,
                user_id: user.id,
                friendship: attributes_for(:friendship)

          post  :create,
                user_id: user.id,
                friendship: attributes_for(:friendship)
        end.to change(Friendship, :count).by(1)
      end

      xit 'does not send friend request if already friends' do
        @friendship = Friendship.create(initiator_id: user.id,
                                        acceptor_id: user2.id)
        expect do
          post  :create,
                user_id: user.id,
                friendship: attributes_for(:friendship,
                                            initiator_id: user.id,
                                            acceptor_id: user2.id)
        end.to change(Friendship, :count).by(0)
      end

      it 'does send multiple request if not already friends' do
        user3 = create(:user)
        expect do
          Friendship.create(initiator_id: user.id,
                            acceptor_id: user2.id)
          post  :create,
                user_id: user.id,
                friendship: attributes_for(:friendship,
                  initiator_id: user.id,
                  acceptor_id: user3.id)
        end.to change(Friendship, :count).by(2)
      end

    end

    describe 'PUT #update' do

      xit 'should update a friend from Pending to Confirmed' do
      end

    end

    describe 'DELETE #destroy' do

      it 'should remove a friendship when Rejected' do
          friendship.save
          expect do
            delete  :destroy,
                    user_id: user.id,
                    id: friendship.id
          end.to change(Friendship, :count).by(-1)
      end

    end

  end

end
