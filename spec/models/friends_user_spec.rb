require 'rails_helper'
describe FriendsUser do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:friend) }
end
