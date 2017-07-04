require 'rails_helper'

describe FriendRequest do
  let(:user1){ create(:user) }
  let(:user2){ create(:user) }
  let(:accepted_status){create(:status, :accepted)}
  let(:accepted_friend_request) do
    create(:friend_request,
           user_one_id: user1.id,
           user_two_id: user2.id,
           status_id: accepted_status.id)
  end

  context "associations" do
    it "belongs to initiator" do
      expect{accepted_friend_request.initiator}.not_to raise_error
    end

    it "belongs to recipient" do
      expect{accepted_friend_request.recipient}.not_to raise_error
    end

    it "belongs to status" do
      expect{accepted_friend_request.status}.not_to raise_error
    end
  end

  context "validations" do
    ## persist
    before{ accepted_friend_request }
    it "has unique :user_one_id, :user_two_id" do
      accepted_friend_request
      friend_request2 = build(:friend_request,
                               user_one_id: user1.id,
                               user_two_id: user2.id,
                               status_id: accepted_status.id)
      expect{friend_request2.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "custom methods" do
    ## persist
    before{ accepted_friend_request }

    context ".relationship_between" do
      it "take two user ids and returns the relationship between them" do
        expect(FriendRequest.relationship_between(user1.id, user2.id)).to be == accepted_friend_request
      end
    end

    context ".friends?" do
      it "takes two user ids and returns a boolean whether or not they're friends" do
        ## friends
        expect(FriendRequest.friends?(user1.id, user2.id)).to be true
        ## not friends
        expect(FriendRequest.friends?(user1.id, create(:user).id)).to be nil
      end 
    end
  end


end
