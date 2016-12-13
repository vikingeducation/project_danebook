require 'rails_helper'
describe FriendRequest do

  let(:user){build(:user)}
  let(:user2){build(:user)}
  let(:user3){build(:user)}
  let(:request){build(:friend_request, user: user, request: user2)}
  let(:request_dup){build(:friend_request, user: user, request: user2)}

  it "validates users can only request the same friend once" do
    request.save
    expect(request_dup).to_not be_valid
    request_dup.update_attributes(user: user3, request: user2)
    expect(request_dup).to be_valid
    request_dup.update_attributes(user: user2, request: user)
    expect(request_dup).to be_valid
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:request) }
end
