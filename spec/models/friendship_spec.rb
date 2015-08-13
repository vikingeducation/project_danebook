require 'rails_helper'

describe Friendship do
  let(:friendship){build(:friendship)}

  it "should be valid with default attributes" do
    expect(friendship).to be_valid
  end

  it "saves with default attributes" do
    expect{ friendship.save! }.to_not raise_error
  end

  it "has a user id" do
    expect(friendship.user_id).to eq(1)
  end

  it "has a friend id" do
    expect(friendship.friend_id).to eq(2)
  end

  it "has a user" do
    expect(friendship).to respond_to(:user)
  end

end
