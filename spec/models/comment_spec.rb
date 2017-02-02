require 'rails_helper'

describe Comment do
  let(:comment){ build(:comment) }

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:post) }
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_least(1).is_at_most(300) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
    it { should have_many(:likes).dependent(:destroy) }
  end

end