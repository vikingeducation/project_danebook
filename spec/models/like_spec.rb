require 'rails_helper'

describe Like do

  let(:like) { build(:like) }
  subject { like }

  before do
    like.save!
  end

  # it 'does not save if violating uniqueness of composite key' do
  #   non_unique_like = create(:like)
  #   expect(non_unique_like).to_not be_valid
  # end

  # it 'does save if not violating uniqueness of composite key'
end
