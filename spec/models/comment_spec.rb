require 'rails_helper'

describe Comment do
  let (:comment){ FactoryGirl.create(:post_comment)}

  it 'is valid if it has a body and a user' do
    expect(comment).to be_valid
  end

  it 'is not valid if body is empty' do
    expect(FactoryGirl.build(:post, body: nil)).not_to be_valid
  end

  it 'is not valid if it does not have a parent user' do
    expect(FactoryGirl.build(:post, user_id: nil)).not_to be_valid
  end


end