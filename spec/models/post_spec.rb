require 'rails_helper'

describe Post do

  describe "validations" do

    it { is_expected.to validate_presence_of(:content) }

  end

  describe "associations" do

    it { is_expected.to have_one(:activity) }
    it { is_expected.to have_one(:owner) }

  end

end
