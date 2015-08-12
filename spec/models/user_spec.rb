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

   context "Friending" do

    #All tests are from user_one's perspective
    let(:user_one){create(:user)}
    let(:user_two){create(:user)}

    context "friends_with?" do

      it "should return true for friends" do
        user_one.friended_users << user_two
        user_two.friended_users << user_one
        expect(user_one.friends_with?(user_two)).to be(true) 
      end

      it "should return false only a friend request was received" do
        user_two.friended_users << user_one
        expect(user_one.friends_with?(user_two)).to be(false) 
      end

      it "should return false if only a friend request was sent" do
        user_one.friended_users << user_two
        expect(user_one.friends_with?(user_two)).to be(false) 
      end

      it "should return false if no request was sent" do
        expect(user_one.friends_with?(user_two)).to be(false) 
      end
    end

    context "friended_by?" do

      it "should return true for friends" do
        user_one.friended_users << user_two
        user_two.friended_users << user_one
        expect(user_one.friended_by?(user_two)).to be(true) 
      end

      it "should return true if only a friend request was received" do
        user_two.friended_users << user_one
        expect(user_one.friended_by?(user_two)).to be(true) 
      end

      it "should return false only a friend request was sent" do
        user_one.friended_users << user_two
        expect(user_one.friended_by?(user_two)).to be(false) 
      end

      it "should return false if no requests was sent" do
        expect(user_one.friended_by?(user_two)).to be(false) 
      end
    end

    context "friended?" do

      it "should return true for friends" do
        user_one.friended_users << user_two
        user_two.friended_users << user_one
        expect(user_one.friended?(user_two)).to be(true) 
      end

      it "should return false only a friend request was received" do
        user_two.friended_users << user_one
        expect(user_one.friended?(user_two)).to be(false) 
      end

      it "should return true if only a friend request was sent" do
        user_one.friended_users << user_two
        expect(user_one.friended?(user_two)).to be(true) 
      end

      it "should return false if no request was sent" do
        expect(user_one.friended?(user_two)).to be(false) 
      end
    end


  end

  
end