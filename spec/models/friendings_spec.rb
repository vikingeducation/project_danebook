require 'rails_helper'

describe Friending do

  let(:friending){ build(:friending) }
  let(:user){ create(:user) }

  it "allows a user to be friends with someone else" do
    expect(friending).to be_valid
  end

  it "doesn't allow a user to friend himself/herself" do
    self_friending = build(:friending, friend_id: user.id, friender_id: user.id)
    expect(self_friending).not_to be_valid
    expect(self_friending.errors.full_messages.first).to eq("Friend can't be friends with yourself!")
  end

  it "doesn't allow a user to friend another user more than once" do
    user2 = create(:user)
    create(:friending, friender_id: user.id, friend_id: user2.id)
    double_friending = build(:friending, friender_id: user.id, friend_id: user2.id)
    expect(double_friending).not_to be_valid
  end

end