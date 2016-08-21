require 'rails_helper'

describe Photo, type: :model do
  let(:post) { build(:post) }

  it 'with a valid description is valid' do
    expect(post).to be_valid
  end



end
