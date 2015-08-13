require 'rails_helper'
require 'pry'

describe Post do

  let(:post){ build(:post) }

  it 'should respond to user' do
    expect(post).to respond_to(:user)
  end

  it 'should respond to many likes' do
    expect(post).to respond_to(:likes)
  end

  it 'should respond to many post_likings' do
    expect(post).to respond_to(:post_likings)
  end

  it 'should respond to many comments' do
    expect(post).to respond_to(:comments)
  end


end