require 'rails_helper'

describe User do
  let(:user){ build(:user) }

  # Happy
  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "has password length bigger then 4" do
    user.password = "1"
    expect(user).to_not be_valid
  end

  it "has password length smaller then 24" do
    user.password = "1"*25
    expect(user).to_not be_valid    
  end

  it "has email with @ sign" do
    user.email = "email.gmail.com"
    expect(user).to_not be_valid
  end
  context "when saving multiple users" do
  before do user.save! end
    it "has raise an error when email is not unique" do
      new_user=build(:user, :email => user.email)
      expect(new_user).to_not be_valid
    end
  end

  context "when creates a user" do
  before do user.save! end
    it "creates a profile after after a user is saved" do
      expect(user.profile.nil?).to eq(false)
    end
  end

  it "responds to profile assosiation" do
    expect(user).to respond_to(:profile)
  end

  it "responds to post assosiation" do
    expect(user).to respond_to(:posts)
  end

  it "responds to comments assosiation" do
    expect(user).to respond_to(:comments)
  end

end

describe "#full_name" do
  let(:user){ build(:user) }
 
  it "gives a string which contains first name" do 
    expect(user.full_name.include?("#{user.first_name}")).to eq(true)
  end

  it "gives a string which contains last name" do 
    expect(user.full_name.include?("#{user.last_name}")).to eq(true)
  end
end



describe "#likes?" do

  let(:user){ create(:user) }
  
  let(:like){ create(:post_like, :user => user) }
  let(:post){ like.liking }

  it "gives true when user has a like" do
    expect(user.likes?(post)).to be(true)
  end

end


  



