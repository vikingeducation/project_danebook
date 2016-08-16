require 'rails_helper'

describe Like, type: :model do
  let(:like){ build(:like) }

  context "associations with children and parents are valid" do
    let(:post_like){ build(:like, :post_like) }

    it { is_expected.to belong_to(:user) }


  end
end
