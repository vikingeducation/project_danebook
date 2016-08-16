require 'rails_helper'

describe Comment do

  describe "validations" do

    it { is_expected.to validate_presence_of(:content) }

  end

  describe "associations" do
    it { is_expected.to belong_to(:commentable) }
    it { is_expected.to have_one(:owner) }
    it { is_expected.to have_one(:activity) }
  end

end
