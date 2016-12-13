require 'rails_helper'

describe Profile do

  let(:profile){build(:profile)}

  it "requires a first_name" do
    profile.update_attributes(first_name: nil)
    expect(profile).to_not be_valid
  end

  it "requires a last_name" do
    profile.update_attributes(last_name: nil)
    expect(profile).to_not be_valid
  end

  it "requires a birthday" do
    profile.update_attributes(birthday: nil)
    expect(profile).to_not be_valid
  end

  it "requires a gender" do
    profile.update_attributes(gender: nil)
    expect(profile).to_not be_valid
  end

  it "does not discriminate gender roles" do
    profile.update_attributes(gender: "Androgyne")
    expect(profile).to be_valid
  end

  it "validates a phone number min and max length are within international formating standards" do
    profile.update_attributes(phone: "#{'1'*4}")
    expect(profile).to be_valid
    profile.update_attributes(phone: "#{'1'*30}")
    expect(profile).to be_valid
    profile.update_attributes(phone: "123")
    expect(profile).to_not be_valid
    profile.update_attributes(phone: "#{'1'*31}")
    expect(profile).to_not be_valid
  end

  it "validates a phone has at least one number" do
    profile.update_attributes(phone: "asdf")
    expect(profile).to_not be_valid
  end

  it "allows your choice of formating your phone number" do
    profile.update_attributes(phone: "+61 13 15 17")
    expect(profile).to be_valid
  end

  it "capitalizes First and Last Name before saving" do
    profile.update_attributes(first_name: "foo", last_name: "bar")
    expect(profile.first_name).to eq("Foo")
    expect(profile.last_name).to eq("Bar")
  end

  describe ".genders" do
    it "returns an array of genders for select options" do
      expect(Profile.genders).to be_a(Array)
      expect(Profile.genders[0]).to eq(["Male", "Male"])
    end
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_one(:bio) }
  it { is_expected.to have_one(:profile_gallery) }
  it { is_expected.to have_many(:images) }
  it { is_expected.to belong_to(:profile_img) }
end
