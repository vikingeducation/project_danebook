require 'rails_helper'
require 'support/factory_girl'

describe Photo do

  let(:photo){build(:photo)}

  it "with all fields filled is valid" do
    expect(photo).to be_valid
  end

  it "must have a user_id" do
    photo = build(:photo, user_id: nil)
    expect(photo).to_not be_valid
  end

  it "must be an image file" do
    photo = build(:photo, picture_content_type: "something")
    expect(photo).to_not be_valid
  end

end
