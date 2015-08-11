require 'rails_helper'

describe User do
  let(:user){build(:user)}

  it "should be valid" do
    expect(user).to be_valid
  end

  it "should have a profile after creation" do
    user.save
    expect(user).to receive(:profile)
    user.profile
  end

  it "should have likes association" do
    expect(user).to receive(:likes)
    user.likes
  end

  it "should have comments association" do
    expect(user).to receive(:comments) 
    user.comments
  end

  it "should have an auth_token on save" do
    user.save
    expect(user.auth_token).not_to be_nil    
  end

  it "should generate a new token on regenerate_token" do
    user.save
    token = user.auth_token
    user.regenerate_token
    regen_token = user.auth_token
    expect(token).not_to eql(regen_token)
  end

  
end