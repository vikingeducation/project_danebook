require 'rails_helper'

describe City do
  let(:city) { build(:city) }

  describe "Validations" do
    it "creates a city with valid attributes" do
      expect(city).to be_valid
    end

    it "validates name length" do
      is_expected.to validate_length_of(:name).is_at_most(20)
    end

    it "validates country name length" do
      is_expected.to validate_length_of(:country).is_at_most(20)
    end
  end

  describe "Associations" do
    it "has many residents" do
      is_expected.to have_many :residents
    end

    it "has many natives" do
      is_expected.to have_many :natives
    end
  end

  describe "#location" do
    it "returns a city's name and country" do
      new_city = build(:city, name: "Moscow", country: "Russia")
      expect(new_city.location).to eql("Moscow, Russia")
    end
  end

end
