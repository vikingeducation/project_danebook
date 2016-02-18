require 'rails_helper'


describe Profile do

  let(:profile) { build(:profile) }


  it 'responds to user' do
    expect(profile).to respond_to(:user)
  end

  it 'is created with valid attributes' do
    expect { profile.save}.to_not raise_error
  end




  end