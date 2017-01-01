require 'rails_helper'

describe Profile do
  let(:profile) { build(:profile) }
  describe "associations" do
    it { should belong_to(:user)}
  end

  describe "validations" do
    it { should validate_presence_of(:first_name)}
    it { should validate_presence_of(:last_name)}

    it "should validate date time for birthday" do
      profile.birthday = "hello?"
      expect{profile.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should validate date before today for birthday" do
      profile.birthday = Time.now + 10.years
      expect{profile.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
