require 'rails_helper'

describe Feedable do
  let(:female){create(:female)}
  let(:user){create(:user, :gender => female)}
  let(:friend){create(:user, :gender => female)}
  let(:friend_request){create(:friend_request, :initiator => user, :approver => friend)}
  let(:activity){Activity.first}

  describe '#create' do
    it 'results in an activity being created' do
      expect {user}.to change(Activity, :count).by(1)
    end

    it 'creates an activity that has a feedable equal to this record' do
      user
      expect(activity.feedable).to eq(user.profile)
    end

    it 'creates an activity that has a verb of create' do
      user
      expect(activity.verb).to eq('update')
    end

    it 'creates an activity for each specified user' do
      user
      friend
      expect {friend_request.accept}.to change(Activity, :count).by(2)
    end
  end
end

