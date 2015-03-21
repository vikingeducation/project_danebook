require 'rails_helper'

describe Like do
  let (:post_like){ FactoryGirl.build(:post_like)}
  let (:photo_like){ FactoryGirl.build(:post_like)}
  let (:comment_like){ FactoryGirl.build(:post_like)}


  it 'is valid with a user liking a post' do
    expect(post_like).to be_valid
  end

  it 'is valid with a user liking a photo' do
    expect(photo_like).to be_valid
  end

  it 'is valid with a user liking a comment' do
    expect(comment_like).to be_valid
  end

  it 'is not valid without a :user_id' do
    expect(FactoryGirl.build(:post_like, user_id: nil)).not_to be_valid
  end

  it 'is not valid without a :likable_id' do
    expect(FactoryGirl.build(:post_like, likable_id: nil)).not_to be_valid
  end

  it 'is not valid without a :likable_type' do
    expect(FactoryGirl.build(:post_like, likable_type: nil)).not_to be_valid
  end



end