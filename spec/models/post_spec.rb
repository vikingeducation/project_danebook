require 'rails_helper'

describe Post, type: :model do
  let(:post) { build(:post) }

  it 'with a valid description is validd' do
    expect(post).to be_valid
  end

  it 'without a first name is invalid' do
    new_post = build(:post, description: nil)
    expect(new_post).not_to be_valid
  end

  context "post attribute validations reject unwanted entries" do
    subject{post}

    it 'validates post description is between 1 and 800 characters' do
      should validate_length_of(:description).
        is_at_least(1).is_at_most(800)
    end
  end

end
