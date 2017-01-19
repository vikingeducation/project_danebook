require 'rails_helper'

describe Like do
  let(:user){build(:user)}
  let(:post){build(:post)}
  let(:user2){build(:user)}
  let(:post2){build(:post)}
  let(:like){build(:like, user: user, post: post)}
  let(:like_dup){build(:like, user: user, post: post)}

  it "validates unique users per post" do
    like.save
    expect(like_dup).to_not be_valid
    like_dup.update_attributes(user: user, post: post2)
    expect(like_dup).to be_valid
    like_dup.update_attributes(user: user2, post: post)
    expect(like_dup).to be_valid
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
end
