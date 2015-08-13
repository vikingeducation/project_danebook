require 'rails_helper'
require 'pry'

describe Comment do

  let(:comment){ build(:comment) }

  it 'should be valid' do
    expect(comment).to be_valid
  end
  
  it 'should respond to parent post association' do
    expect(comment).to respond_to(:post)
  end

  it 'should respond to parent user association' do
    expect(comment).to respond_to(:user)
  end 

  it 'should respond to child likes association' do
    expect(comment).to respond_to(:likes)
  end 

end