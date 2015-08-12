require "rails_helper"

describe Photo do
  let(:photo) { build(:photo) }

  context "Validations" do

    it "is valid with all attributes" do
      expect(photo).to be_valid
    end

  end
end