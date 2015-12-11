require 'rails_helper'

describe Friendship do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:friend){create(:user, :gender => male)}
  let(:friend_request){create(:friend_request, :initiator => user, :approver => friend)}
  let(:friendship){create(:friendship, :initiator => user, :approver => friend)}

  before do
    FriendRequest.skip_callback(:update, :after, :create_friendship_if_approved)
  end

  after do
    FriendRequest.set_callback(:update, :after, :create_friendship_if_approved)
  end

  describe '#create' do
    context 'there is an existing approved friend request' do
      before do
        friend_request.update!(:approved => true)
      end

      it 'creates a friendship' do
        expect {friendship}.to change(Friendship, :count).by(1)
      end

      it 'destroys the friend request' do
        expect {friendship}.to change(FriendRequest, :count).by(-1)
      end

      it 'creates an activity for each friend' do
        expect {friendship}.to change(Activity, :count).by(2)
      end
    end

    context 'there is not an existing approved friend request' do
      it 'it raises an error' do
        expect {friendship}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end

