require 'rails_helper'

describe Photo do

let(:photo){ create(:photo) }

it "is valid with default attributes" do
  expect(photo).to be_valid
end

it{ should belong_to(:user) }

it "doesn't allow invalid formats" do
  not_a_photo = build(:photo, avatar_content_type: "pdf")
  expect(not_a_photo).not_to be_valid
end


end