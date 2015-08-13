require 'rails_helper'

include ActionDispatch::TestProcess

RSpec.describe Photo, type: :model do

  let(:photo) { build(:photo) }

  it "is valid with default attributes" do
    expect(photo).to be_valid
  end

  it "is associated with a user" do
    expect(photo).to respond_to(:user)
  end

  context "validations" do

    it "isn't valid without an uploader" do
      photo.user_id = nil
      expect(photo).not_to be_valid
    end

    it "isn't valid without an attachment" do
      photo.data = nil
      expect(photo).not_to be_valid
    end

    it "is valid if it doesn't come from an outside source" do
      photo.img_url = ""
      expect(photo).to be_valid
    end

    it "is not valid if the url is not a url" do
      photo.img_url = "htp://test.com"
      expect(photo).not_to be_valid
    end

  end


end
