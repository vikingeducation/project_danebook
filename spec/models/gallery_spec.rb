require 'rails_helper'

describe Gallery do

  let(:user){build(:user)}
  let(:user2){build(:user)}
  let(:gallery){build(:gallery, user: user, title: "test")}
  let(:gallery_dup){build(:gallery, user: user, title: "test")}

  it "validates unique gallery titles per user" do
    gallery.save
    expect(gallery_dup).to_not be_valid
    gallery_dup.update_attributes(user: user, title: "not dup")
    expect(gallery_dup).to be_valid
    gallery_dup.update_attributes(user: user2, title: "test")
    expect(gallery_dup).to be_valid
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:images) }
end
