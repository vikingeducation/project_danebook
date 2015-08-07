require 'rails_helper'

RSpec.describe Friend, type: :model do

  let(:friend){ build(:friend) }
  
  it 'should respond to users association' do
    expect(friend).to respond_to(:user)
  end

  # describe '#return_friends of a user' do
  #   expect(Friend.frist).to 
  
  # it 'shoud return a friend id' do
  #   new_friend = build(:friend)
  #   user.friends << new_user
  #   expect(user.friends[])
  # end
end
