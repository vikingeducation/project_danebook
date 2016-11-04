require 'rails_helper'

describe Friending do
  describe 'associations' do
    it { is_expected.to belong_to(:friending_initiator) }
    it { is_expected.to belong_to(:friending_recipient) }
  end
end
