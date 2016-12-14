require 'rails_helper'

describe Post do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
  it { is_expected.to have_many(:likes) }
  it { is_expected.to have_many(:liked_users) }
  it { is_expected.to have_many(:comments) }

  it "includes User with all posts to avoid N+1" do
    create(:post)
    expect { Post.first.user }.to_not exceed_query_limit(2)
  end
end
