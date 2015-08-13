require 'rails_helper'
require 'pry'

describe Like do

  let(:like){ build(:like)}
  
  it 'shoud respond to parent post assocation' do
    expect(like).to respond_to(:post)
  end

  it 'shoud respond to parent comment association' do
    expect(like).to respond_to(:post)
  end

  it 'shoud respond to parent user' do
    expect(like).to respond_to(:user)
  end

  it 'shoud respond to its polymorpohic self' do
    expect(like).to respond_to(:likeable)
  end

  it 'shoud return true if user is in objects likes' do

    expect(Like.all.include_user?(like.user)).to eq(true)
  end

end