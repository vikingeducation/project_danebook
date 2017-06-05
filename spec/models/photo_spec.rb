require 'rails_helper'

describe Photo do
  let(:photo){ create(:photo)}
  let(:friend){ create(:user, :with_profile)}
  context 'validations' do
    it 'is valid with default atts' do
      expect(photo).to be_valid
    end
    it 'invalid without image' do
      photo.image = nil
      expect(photo).to be_invalid
    end
    it 'is invalid without user' do
      photo.user = nil
      expect(photo).to be_invalid
    end
    it 'does not allow non-image files' do
      photo.image = Rack::Test::UploadedFile.new(Rails.root.join('README.md'), 'text/markdown')
      expect(photo).to be_invalid
    end
  end
  context 'instance methods' do
    describe '#upload_date' do
      it 'returns a properly formatted upload date' do
        photo.image_updated_at = Date.new(2017,1,12)
        expect(photo.upload_date).to eq('12 January 2017')
      end
    end
    describe '#liked_by?' do
      it 'returns true/false correctly' do
        photo.likers << friend
        expect(photo.liked_by?(friend)).to eq(true)
        expect(photo.liked_by?(create(:user, :with_profile))).to eq(false)
      end
    end

  end
  context 'associations' do
    it 'responds to image' do
      expect(photo).to respond_to(:image)
    end
    it 'responds to likes' do
      expect(photo).to respond_to(:likes)
    end
    it 'responds to comments' do
      expect(photo).to respond_to(:comments)
    end
  end
end
