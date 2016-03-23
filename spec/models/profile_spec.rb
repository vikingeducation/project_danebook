require 'rails_helper'

describe Profile do
  let(:profile) { build(:profile) }

  describe "attributes" do
    it "can all be nil" do
      expect(profile).to be_valid
    end

    it "set to nil can be saved to database" do
      expect{ profile.save! }.to_not raise_error
    end

    it "can all be blank" do
      new_profile = build(:profile,
        gender: "",
        college: "",
        from: "",
        lives: "",
        number: "",
        words: "",
        about: ""
      )
      expect(new_profile).to be_valid
    end

    it "gender can be set to \"Male\"" do
      new_profile = build(:profile, gender: "Male")
      expect(new_profile).to be_valid
    end

    it "gender can be set to \"Female\"" do
      new_profile = build(:profile, gender: "Male")
      expect(new_profile).to be_valid
    end

    it "invalidates college with character count above 140" do
      new_profile = build(:profile, college: "a" * 141)
      expect(new_profile).to_not be_valid
    end

    it "invalidates from with character count above 140" do
      new_profile = build(:profile, from: "a" * 141)
      expect(new_profile).to_not be_valid
    end

    it "invalidates lives with character count above 140" do
      new_profile = build(:profile, lives: "a" * 141)
      expect(new_profile).to_not be_valid
    end

    it "invalidates number with character count above 30" do
      new_profile = build(:profile, number: "a" * 31)
      expect(new_profile).to_not be_valid
    end

    it "invalidates words with character count above 2000" do
      new_profile = build(:profile, lives: "a" * 2001)
      expect(new_profile).to_not be_valid
    end

    it "invalidates about with character count above 2000" do
      new_profile = build(:profile, lives: "a" * 2001)
      expect(new_profile).to_not be_valid
    end
  end

  describe "associations" do
    it "responds to the user association" do
      expect(profile).to respond_to(:user)
    end

    it "linking a valid user succeeds" do
      new_user = create(:user)
      profile.save
      new_user.profile = profile
      new_user.save
      expect(new_user.profile).to be_valid
    end

    it "linking nonexistent user fails" do
      profile.save
      profile.user_id = 9999
      expect(profile).to_not be_valid
    end
  end
end
