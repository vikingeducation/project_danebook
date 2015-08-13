require 'rails_helper'

describe Photo do
  let(:photo){build(:photo)}

  it "should be valid with default attributes" do
    expect(photo).to be_valid
  end

  it "saves with default attributes" do
    expect{ photo.save! }.to_not raise_error
  end

  it "has a user id" do
    expect(photo.user_id).to eq(1)
  end

  it "has a user" do
    expect(photo).to respond_to(:user)
  end

end
