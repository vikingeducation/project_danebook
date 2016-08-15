require 'rails_helper'

describe Comment do
  let(:comment){ build(:comment) }

  it "is valid with default attributes" do
    expect(comment).to be_valid
  end

   it "is not valid with an empty body" do
    bad_comment = build(:comment, body: "")
    expect(bad_comment).not_to be_valid
  end

   it {should have_many(:likes)}

   it {should belong_to(:post) }
   it {should belong_to(:user) }

  describe "#posted_date" do
    it "returns the date with day of the week" do
    comment.save
    expect(comment.posted_date).to eq("Monday 08/15/2016")
    end
  end

end