require 'rails_helper'

describe Activity do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:friend){create(:user, :gender => male)}
  let(:post){create(:post, :user => user)}
  let(:friend_request){create(:friend_request, :initiator => user, :approver => friend)}
  let(:activity){Activity.first}

  before do
    user
  end

  describe '#user' do
    it 'returns the user to which this activity belongs' do
      expect(activity.user).to eq(user)
    end
  end

  describe '#feedable' do
    it 'returns the feedable to which this activity belongs' do
      expect(activity.feedable).to eq(user.profile)
    end
  end

  describe '#feed_for' do
    it 'returns all activities for the given user and friends' do
      post
      friend_request.accept
      activitie_types = Activity.feed_for(user).map(&:feedable_type)
      expect(activitie_types.sort).to eq(['Friendship', 'Friendship', 'Profile', 'Post', 'Profile'].sort)
    end
  end

  describe '#timeline_for' do
    it 'returns all activities for just the given user' do
      post
      activitie_types = Activity.timeline_for(user).map(&:feedable_type)
      expect(activitie_types.sort).to eq(['Profile', 'Post'].sort)
    end
  end
end

