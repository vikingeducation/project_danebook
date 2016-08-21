require 'rails_helper'

describe Photo, type: :model do
  let(:user) { create(:user) }

  it 'with a valid description is validd' do
    photo = user.photo_posts.create
    expect(photo).to be_valid
  end

  context "post attribute validations reject unwanted entries" do
    let(:photo_two){ user.photo_posts.create }
    subject{photo_two}

    it 'validates post description is between 1 and 800 characters' do
      should validate_length_of(:description).is_at_most(500)
    end
  end

  context "test assocations with user" do

    it { is_expected.to have_many(:postings) }
    it { is_expected.to have_many(:authors) }

    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:commenters) }

    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:likers) }
  end

  context "helper methods" do
    it 'returns pluralized name of Photo class when to_s called on instance' do
      photo = user.photo_posts.create(description: "blah")
      expect(photo.to_s).to eq("photos")
    end
  end
end
