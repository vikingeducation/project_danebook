require 'rails_helper'

describe Comment do

  let(:comment) { build(:comment) }

  it 'allows comments of appropriate length' do
    expect(comment).to be_valid
  end

  it 'should not allow comments longer than 1000 characters' do
    comment.body = 'a' * 1001 # check out shoulda
    expect(comment).to be_invalid
  end

  it 'responds to author' do
    expect(comment).to respond_to(:author)
  end

end