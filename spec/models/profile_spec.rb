require "rails_helper"

describe Profile do
  let(:profile){ create(:profile) }

  context "associations" do
    it "belongs to a user" do
      expect{profile.user}.not_to raise_error
    end
  end

  context "#full_name" do
    it "returns the concatenation of the first ans last name" do
      expect(profile.full_name).to be == (profile.first_name + " " + profile.last_name)
    end
  end

end
