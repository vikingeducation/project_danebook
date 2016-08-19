require 'rails_helper'

describe Comment do

  let(:comment){ build(:comment) }

  it "is valid with default attributes" do
    expect(comment).to be_valid
  end

  it "checks for body presence" do
    should validate_presence_of(:body)
  end

  #Associations
  it { should belong_to(:user) }
  it { should belong_to(:post) }

end