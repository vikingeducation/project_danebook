require 'rails_helper'

describe Post do
  let (:post){ FactoryGirl.create(:post)}

  it 'is valid if it has a body and a user' do
    expect(post).to be_valid
  end

  it 'is not valid if body is empty' do
    expect(FactoryGirl.build(:post, body: nil)).not_to be_valid
  end

  it 'is not valid if it does not have a parent user' do
    expect(FactoryGirl.build(:post, user_id: nil)).not_to be_valid
  end


end