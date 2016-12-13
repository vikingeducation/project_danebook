require 'rails_helper'

describe Post do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
  it { is_expected.to have_many(:likes) }
  it { is_expected.to have_many(:liked_users) }
  it { is_expected.to have_many(:comments) }
end
