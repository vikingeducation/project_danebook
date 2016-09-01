require 'rails_helper'

describe Like do
  let(:likeb){build(:like)}
  let(:likec){create(:like)}

  it "requires likable_id, liker_id to be valid" do
    expect(likeb).to be_valid
  end
  it "has polymorphic assocation #likable" do
    expect(likec).to respond_to(:likable)
  end
  it "has assocation #liker" do
    expect(likec).to respond_to(:likable)
  end


end
