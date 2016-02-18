require 'rails_helper'

describe Friending do
  let(:friending) { build(:friending) }

  describe "associations" do

    it "is valid with default associations" do
      expect(friending).to be_valid
    end

    it "is not valid if missing a friendship" do
      missing_friend = build(:friending, friend_initiator: nil)
      expect(missing_friend).to_not be_valid
    end

    it "responds to parent associations" do
      expect(friending).to respond_to(:friend_initiator)
      expect(friending).to respond_to(:friend_receiver)
    end
  end

end