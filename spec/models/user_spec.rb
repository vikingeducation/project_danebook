require 'rails_helper'

describe User do

  let(:user){ create(:user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "is invalid with no attributes" do
    new_user = build(:user, :without_attributes)
    expect(new_user).to_not be_valid
  end

  it "has a secure password" do
    is_expected.to have_secure_password
  end

  it "has password between 8 and 24 characters" do
    should validate_length_of(:password).is_at_least(8).is_at_most(24)
  end

  it "has email uniqueness" do
    should validate_uniqueness_of(:email)
  end

  it "responds to profile association" do
    expect(user).to respond_to(:profile)
  end

  it "responds to posts association" do
    expect(user).to respond_to(:posts)
  end

  it "responds to likes association" do
    expect(user).to respond_to(:likes)
  end

  it "responds to comments association" do
    expect(user).to respond_to(:comments)
  end

  it "checks to make sure regenerate_auth_token creates new token" do
    old_token = user.auth_token
    user.regenerate_auth_token
    expect(old_token).to_not eq(user.auth_token)
  end

  it "runs the find_like method and receives correct output" do
    like = create(:like)
    post = create(:post)
    like.post = post
    user.likes << like
    expect(user.find_like(post).first).to eq(like)
  end

end