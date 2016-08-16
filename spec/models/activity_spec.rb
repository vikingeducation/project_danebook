require 'rails_helper'

describe Activity do

  describe "associations" do

    it { is_expected.to belong_to(:postable) }
    it { is_expected.to belong_to(:author) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:likers) }
    it { is_expected.to have_many(:comments) }

  end

end
