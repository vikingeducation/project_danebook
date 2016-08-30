require 'rails_helper'

describe Birthday do
  let(:birthday) { build(:birthday,:with_valid_date) }
  let(:invalid_bday) { build(:birthday,:with_invalid_date) }

  describe "#reasonable_date" do
    it "allows for dates earlier than 18 years ago" do
      expect(birthday.save).to eq(true)
    end

    it "rejects dates later than 18 years ago" do
      expect(invalid_bday.save).to eq(false)
    end
  end
end
