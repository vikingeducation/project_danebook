
require 'rails_helper'

describe Profile do

  let(:default_profile){ build(:profile) }

  describe 'default_profile' do 

    it "is valid with default attributes" do
      expect(default_profile).to be_valid
    end

    it "is an Profile instance" do
      expect(default_profile).to be_a Profile
    end


    it "has user of User instance" do
      expect(default_profile.user).to be_a User
    end
  end

  describe 'default profile saved values' do   

    it "has first_name attribute set" do
      default_profile.save!
      expect(default_profile.first_name).to be_truthy
    end

    it "has last_name attribute set" do
      default_profile.save!
      expect(default_profile.last_name).to be_truthy
    end

    it "has gender attribute set" do
      default_profile.save!
      expect(default_profile.gender).to be_truthy
    end

    it "has hometown attribute set" do
      default_profile.save!
      expect(default_profile.hometown).to be_truthy
    end

    it "has domicile attribute set" do
      default_profile.save!
      expect(default_profile.domicile).to be_truthy
    end 

  end

  describe 'checks first name' do   

    it "to not be nil" do
      new_profile = build(:profile, first_name: nil)
      expect(new_profile).to_not be_valid
    end

    it "to not have only spaces" do
      new_profile = build(:profile, first_name: "    ")
      expect(new_profile).to_not be_valid
    end

  end

  describe 'checks last name' do   
    #let(:user_x){ create(:user) }

    it "to not be nil" do
      new_profile = build(:profile, last_name: nil)
      expect(new_profile).to_not be_valid
    end

    it "to not have only spaces" do
      new_profile = build(:profile, last_name: "    ")
      expect(new_profile).to_not be_valid
    end

  end

  describe 'responds to association' do
    
    it "user association" do
      expect(default_profile).to respond_to(:user)
    end
  end

  describe 'birthdate' do
    
    it "is not in future" do
      default_profile.birthdate = 1.days.from_now
      expect(default_profile).to_not be_valid
    end

    
    it "can be empty" do
      default_profile.birthdate = nil
      expect(default_profile).to be_valid
    end

  end


  describe 'user profile' do
    
    it "is one per user" do
      
      default_user = create(:user)

      profile_one = create(:profile, user: default_user)
      profile_two = build(:profile, user: default_user)

      expect {profile_two.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "is always related to a valid user" do
      
      default_user = create(:user)

      profile_one = create(:profile)
      profile_one.user_id = 12345
      expect(profile_one).to_not be_valid
    end

  end
end 