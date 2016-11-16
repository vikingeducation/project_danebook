require 'rails_helper'

describe Post do
  let (:post){ build(:post)}

  it "is valid with default attributes" do
    expect(post).to be_valid
  end

  it "is not valid with an empty body" do
    bad_post = build(:post, body: "")
    expect(bad_post).not_to be_valid
  end

  it {should have_many(:likes)}

  describe "#posted_date" do
    it "returns the date with day of the week" do
    post.save
    expect(post.posted_date).to eq("Monday 08/15/2016")
    end
  end

end