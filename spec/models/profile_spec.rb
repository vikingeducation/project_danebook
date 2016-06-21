require 'rails_helper'

describe Profile do 
  let(:profile){ create(:profile) }
  context "Validation" do
    it 'should be valid with basic informations' do
      expect(profile).to be_valid
    end

    it 'should not be valid without a first name' do
      invalid_attributes(profile, "last_name=")
      
    end

    it "should not be valid without a last name" do
      invalid_attributes(profile, "last_name=")
    end

    it 'should not be valid without a user' do
      invalid_attributes(profile, "user_id=")
    end

    it "should not be valid if the user doesnt exist" do
      user = create(:user)
      profile.user_id = user.id
      user.destroy
      expect(profile).not_to be_valid
    end
  end
end