require 'rails_helper'

describe Post do

  let(:user){create(:user)}
  let(:post){user.posts_written.create(attributes_for(:post))}

  it "is valid with valid parameters" do
    expect(post).to be_valid
  end

  it {should belong_to(:author)}

  it {should belong_to(:receiver)}

  it {should have_many(:comments)}

  it {should have_many(:likes)}







end