require 'rails_helper'

describe Photo do

  describe 'Owner association' do

    it { should belong_to(:owner) }

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
