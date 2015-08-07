require 'rails_helper'
require 'support/factory_girl'

describe Post do

  let(:post){build(:post)}

  it "must have a user_id" do
    expect(post).to be_valid
  end

  it "cannot not have a user_id" do
    post = build(:post, user_id: nil)
    expect(post).to_not be_valid
  end

  it "must have a body" do
    post = build(:post, body: "")
    expect(post).to_not be_valid
  end

  it "must have a body" do
    post = build(:post, body: "something")
    expect(post).to be_valid
  end

end