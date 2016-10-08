require 'rails_helper'

describe Posting, type: :model do
  let(:posting){ build(:posting) }

  context "validations" do
    it { is_expected.to validate_presence_of(:postable) }

    it { is_expected.to validate_presence_of(:user) }
  end

  context "associations" do
    subject{ posting }

    it { is_expected.to belong_to(:postable) }

    it { is_expected.to belong_to(:user) }
  end
end
