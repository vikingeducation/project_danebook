require 'rails_helper'

describe Notifiable do
  let(:female){create(:female)}
  let(:user){create(:user, :gender => female)}

  describe '#create' do
    it 'results in a notification email being queued' do
      expect {user}.to change(Delayed::Job, :count).by(1)
    end
  end
end

