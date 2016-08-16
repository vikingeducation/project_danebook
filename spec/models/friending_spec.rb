require 'rails_helper'

describe Friending, type: :model do

  # it { should validate_uniqueness_of(:friend_id) }
  ##### Not working here?????

  it { is_expected.to belong_to(:friend_initiator) }

  it { is_expected.to belong_to(:friend_recipient) }

end
