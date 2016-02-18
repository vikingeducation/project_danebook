require 'rails_helper.rb'

describe Friending do

  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let(:friending) { create(:friending, friender: user_1, friended: user_2) }

  # before do
  #   user_1.friendeds << user_2
  # end

  it "doesn't allow user to friend the same another twice" do
    # user_1.friendeds << user_2
    # expect(user_1.friendeds << user_2).to be_valid
    friending
    expect(build(:friending, friender: user_1, friended: user_2)).to_not be_valid
  end
end
