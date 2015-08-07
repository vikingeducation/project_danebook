require 'rails_helper'

describe Profile do
  let(:profile){build(:profile)}

  it "should show who it belongs to" do
    expect(profile).to respond_to(:user)
  end
end