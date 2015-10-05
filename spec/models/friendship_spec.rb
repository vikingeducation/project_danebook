require 'rails_helper'

describe Friendship do

  let(:friendship){ build(:friendship) }

  context 'associations' do

    it 'should respond to friend_initiator' do
      expect(friendship).to respond_to(:friend_initiator)
    end

    it 'should respond to friend_acceptor' do
      expect(friendship).to respond_to(:friend_acceptor)
    end

  end

  context 'validations' do

    it 'should not allow a repeat friendship request' do
      user1 = create(:user)
      user2 = create(:user)
      friendship2 = Friendship.new(initiator_id: user1.id,
                                    acceptor_id: user2.id)
      expect {friendship2.save}.to change {Friendship.count}.by(1)
      expect {friendship2.save}.to change {Friendship.count}.by(0)
    end

  end

  context 'methods' do

    before(:example) do
      @user1 = create(:user)
      @user2 = create(:user)
      @friendship2 = create(:friendship, initiator_id: @user1.id, acceptor_id: @user2.id)
    end

    it 'checks if the current page visitor is a friend' do
      expect(@friendship2.is_a_friend?(@user2)).to be_truthy
      expect(@friendship2.is_a_friend?(@user1)).to be_truthy
    end

    it 'checks if either the page visitor and page owner are friends' do
      expect(@friendship2.is_you?(@user2, @user1)).to be_truthy
      expect(@friendship2.is_you?(@user1, @user2)).to be_truthy
    end

  end


end
