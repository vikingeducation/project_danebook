require 'rails_helper'
require 'pry'

describe Profile do

  let(:profile){ build(:profile) }
  
  it 'should have a user asscoiated with it' do
    expect(profile).to respond_to(:user)
  end


end