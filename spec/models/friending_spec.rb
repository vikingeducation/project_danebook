require 'rails_helper'

describe Friending, type: :model do

  let(:friending){ build(:friending) }


  describe "Associations" do
    it 'responds to author associations' do
      expect(friending).to respond_to(:friend_initiator)
      expect(friending).to respond_to(:friend_recipient)
    end
  end #associations


  describe "Validations" do
    let(:initiator){ create(:user) }
    let(:recipient){ create(:user) }

    it "is valid with default attributes" do
      expect(friending).to be_valid
    end

    it "is invalid without an initiator" do
      friending = build(:friending, friend_initiator: nil)
      expect(friending).to_not be_valid
    end

    it "is invalid without a recipient" do
      friending = build(:friending, friend_recipient: nil)
      expect(friending).to_not be_valid
    end

    it "only allows a user to friend another user once at a time" do
      first_time = Friending.create(initiator_id: initiator.id, recipient_id: recipient.id)
      second_time = Friending.create(initiator_id: initiator.id, recipient_id: recipient.id)
      expect(second_time).to_not be_valid
    end

  end #validations

end #Friending
