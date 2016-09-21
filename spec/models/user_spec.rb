require 'rails_helper'

describe User do

  let(:user){create(:user)}

  it "is valid with an email and a password" do
    expect(user).to be_valid
  end
  it { should validate_uniqueness_of(:email) }

  it "should have an email in the correct format" do 
    expect(user.email.split('').include?("@")).to be true
  end

  it { should validate_length_of(:password).is_at_least(6).on(:create)}

  it { should have_secure_password }

  it { should have_one(:profile)}

  it { should accept_nested_attributes_for(:profile)}

  it { should have_many(:posts_written)}

  it { should have_many(:posts_received)}

  it { should have_many(:comments_written)}

  it { should have_many(:likes_given)}

  let(:post){user.posts_written.create(attributes_for(:post))}
  it "likes_post should return 1 if the user likes the post" do
    user.likes_given.create(attributes_for(:like, likeable_id: post.id, likeable_type: "Post"))
    expect(user.likes_post?(post.id, "Post").length).to eq(1)
  end

  it "likes_post should return 0 if the user does not like the post" do
    expect(user.likes_post?(post.id, "Post").length).to eq(0)
  end








end