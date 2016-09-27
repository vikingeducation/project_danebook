require 'rails_helper'

RSpec.describe Friending, type: :model do
  let(:my_user){ create(:user) }
  let(:friend_user){ create(:user) }
  it "should be unique" do
    my_friendship = create(:friending, friend_initiator: my_user,
                                       friend_recipient: friend_user)
    dup_friendship = Friending.new(friend_initiator: my_user,
                                       friend_recipient: friend_user)
    expect(dup_friendship).to be_invalid
  end
end
