require 'rails_helper'

describe Like do
  let(:like){build(:like)}

  it "has a user id" do
    expect(like.user_id).to eq(1)
  end

  it "raises an error if no user id provided" do
    like.user_id = nil
    expect(like).not_to be_valid
  end

  it "has a user" do
    expect(like).to respond_to(:user)
  end

end
