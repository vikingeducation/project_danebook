require 'rails_helper'

describe User do
  let(:user){build(:user)}

  it "should be valid" do
    expect(user).to be_valid
  end

  it "should have a profile" do
    expect{user.profile}.to raise_error
  end
  
  
end