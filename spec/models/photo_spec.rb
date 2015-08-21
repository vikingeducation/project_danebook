require 'rails_helper'

describe Photo do

  describe 'associations' do

    it { should belong_to(:owner) }

    it { should have_many(:comments).dependent(:destroy) }

  end


  describe 'validations' do

    it { should have_attached_file(:photo) }

    it { should validate_attachment_content_type(:photo).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml') }

    it { should validate_attachment_size(:photo).
                less_than(2.megabytes) }

  end


  describe 'when saving via URL' do

    let(:user) { create(:user) }

    it 'successfully saves the file' do
      photo = user.photos.build
      photo.photo_from_url=("https://www.google.com/images/srpr/logo11w.png")
      photo.save!

      expect(photo.photo_file_name).not_to be_nil
      expect(photo.photo_content_type).not_to be_nil
      expect(photo.photo_file_size).not_to be_nil
      expect(photo.photo_updated_at).not_to be_nil
    end

  end

end
