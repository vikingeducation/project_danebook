require 'rails_helper'

describe Friending, type: :model do
  subject{ create(:friending) }

  context "validations" do
    it { is_expected.to validate_uniqueness_of(:friend_id).scoped_to(:friender_id)}
  end

  context "associations " do

    it { is_expected.to belong_to(:friend_initiator) }

    it { is_expected.to belong_to(:friend_recipient) }
  end
end
