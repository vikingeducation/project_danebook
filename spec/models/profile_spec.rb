require "rails_helper"

describe Profile do
  let(:profile) { build(:profile) }

  context "Validations" do

    it "is valid with attributes" do
      expect(profile).to be_valid
    end
    
  end

  context "Associations" do
    it "should respond to user" do
      expect(profile).to respond_to(:user)
    end
  end

  context "Instance Methods" do

    specify "Method birthday should return date formated as month/day/year" do
      expect(profile.birthday).to eq("#{profile.birthday_month}/#{profile.birthday_day}/#{profile.birthday_year}")
    end

    specify "Method full_name should return 'first_name last_name'" do
      expect(profile.full_name).to eq("#{profile.first_name} #{profile.last_name}")
    end
  end

end