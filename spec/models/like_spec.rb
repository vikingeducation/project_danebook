require 'rails_helper'

describe Like do

  let(:like){ build(:like) }

  it "is valid with default attributes" do
    expect(like).to be_valid
  end

  it "has uniqueness of user_id in conjunction with post_id" do
    should validate_uniqueness_of(:user_id).scoped_to(:post_id)
  end

  #Associations
  it { should belong_to(:user) }
  it { should belong_to(:post) }

end