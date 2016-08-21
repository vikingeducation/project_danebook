require 'rails_helper'

describe Comment, type: :model do

  let(:comment) { build(:comment) }

  it 'with a valid description is validd' do
    expect(comment).to be_valid
  end

  it 'without a first name is invalid' do
    new_comment = build(:comment, description: nil)
    expect(new_comment).not_to be_valid
  end

  context "comment attribute validations reject unwanted entries" do
    subject{comment}

    it { validate_length_of(:description).is_at_least(1).is_at_most(500) }
  end

  context "comment should be able to be added to post" do
    subject{comment}
    let(:post) { build(:post) }

    it { is_expected.to belong_to(:post) }

    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:likes) }

    it { is_expected.to have_many(:likers).through(:likes) }

  end

end
