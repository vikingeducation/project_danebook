require 'rails_helper'

describe Like do

  let(:post_like){build(:post_like)}
  let(:comment_like){build(:comment_like)}

  it "is responds to assocation with posts" do
    expect(post_like).to respond_to(:likeable)
  end

  it "is responds to assocation with users" do
    expect(post_like).to respond_to(:user)
  end

  it "is responds to assocation with comments" do
    expect(comment_like).to respond_to(:likeable)
  end

  it "do not allow invalid types" do 
    invalid_like = build(:post_like, :likeable_type => 'User')
    expect(invalid_like).not_to be_valid
  end

end
