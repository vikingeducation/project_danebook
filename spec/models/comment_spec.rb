require 'rails_helper'

describe Comment do
  let (:post_comment){ FactoryGirl.build(:post_comment)}
  let (:photo_comment){ FactoryGirl.build(:post_comment)}


  it 'is valid with a user and body and a parent post' do
    expect(post_comment).to be_valid
  end

  it 'is valid with a user and body and a parent photo' do
    expect(photo_comment).to be_valid
  end

  it 'is not valid with an empty body' do
    expect(FactoryGirl.build(:post_comment, body: "")).not_to be_valid
  end

  it 'is not valid without a :user_id' do
    expect(FactoryGirl.build(:post_comment, user_id: nil)).not_to be_valid
  end

end