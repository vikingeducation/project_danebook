require 'rails_helper'

describe Like, type: :model do
  let(:like){ build(:like) }

  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:likeable) }

  context "associations with children and parents are valid" do
    subject{ like }

    it { is_expected.to belong_to(:likeable) }

    it { is_expected.to belong_to(:user) }

  end
end
