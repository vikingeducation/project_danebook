require 'rails_helper'

describe Post do

  let(:post) { build(:post) }

  it "is valid with default attributes" do
    expect(post).to be_valid
  end

  it "is invalid without default attributes" do
    new_post = build(:post, :without_attributes)
    expect(new_post).to_not be_valid
  end

  it "checks for body presence" do
    should validate_presence_of(:body)
  end

  #Associations
  it { should have_many(:likes) }
  it { should have_many(:comments) }

end