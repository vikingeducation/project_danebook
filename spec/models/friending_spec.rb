require "rails_helper"

describe Friending do
  let(:friending) { create(:friending) }
  let(:user) { create(:user) }

  context "Validations" do

    it "is valid with a friend id and a friender id" do
      expect(friending).to be_valid
    end

    specify "A user can only friend another user once" do
      new_friending = create(:friending)
      new_friending.friend_initiator = friending.friend_initiator
      new_friending.friend_recipient = friending.friend_recipient

      expect(new_friending).not_to be_valid
    end

    specify "A user cannot friend himself" do
      friending.friend_initiator = user
      friending.friend_recipient = user

      expect(friending).not_to be_valid
    end

  end

  context "Associations" do
    it "should respond to friend_initiator" do
      expect(friending).to respond_to(:friend_initiator)
    end
    it "should respond to friend_recipient" do
      expect(friending).to respond_to(:friend_recipient)
    end
  end
end
