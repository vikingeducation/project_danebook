require 'rails_helper'

describe Profile do
  let(:profile) { build(:profile) }

  describe "#first_name" do
    
    it "has a first name" do
      expect(profile).to respond_to(:first_name)
    end

    it "validates the presence of a first name" do
      should validate_presence_of(:first_name)
    end

    it "accepts a first name with at least one character" do
      should validate_length_of(:first_name).is_at_least(1)
    end

    it "accepts a first name with at most 255 characters" do
      should validate_length_of(:first_name).is_at_most(255)
    end

  end

  describe "#last_name" do

    it "has a last name" do
      expect(profile).to respond_to(:last_name)
    end

    it "validates the presence of a last name" do
      should validate_presence_of(:last_name)
    end

    it "accepts a last name with at least one character" do
      should validate_length_of(:last_name).is_at_least(1)
    end

    it "accepts a last name with at most 255 characters" do
      should validate_length_of(:last_name).is_at_most(255)
    end

  end

  it "has words from the user" do
    expect(profile).to respond_to(:words)
  end

  it "has words about the user" do
    expect(profile).to respond_to(:about)
  end

  it "has a college" do
    expect(profile).to respond_to(:college)
  end

  describe "associations" do
    it "has a birthday" do
      expect(profile).to have_one(:birthday)
    end

    it "has contact information" do
      expect(profile).to have_one(:contact_info)
    end

    it "has a hometown" do
      expect(profile).to have_one(:hometown)
    end

    it "has a residence" do
      expect(profile).to have_one(:residence)
    end
  end

end