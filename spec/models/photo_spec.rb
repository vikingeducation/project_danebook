require 'rails_helper'

describe Photo do
  let (:photo){ FactoryGirl.build(:photo)}


  it 'is valid up to size of 2 megabytes' do
    expect(FactoryGirl.build(:photo, image_file_size: 2.megabytes - 1)).to be_valid
  end

  it 'is not valid up above 2 megabytes' do
    expect(FactoryGirl.build(:photo, image_file_size: 2.megabytes)).not_to be_valid
  end

  it 'is not valid without a user' do
    expect(FactoryGirl.build(:photo, user_id: nil)).not_to be_valid
  end

  it 'allows JPEGS' do
    expect(FactoryGirl.build(:photo, image_content_type: "image/jpeg")).to be_valid
  end

  it 'allows GIFs' do
    expect(FactoryGirl.build(:photo, image_content_type: "image/gif")).to be_valid
  end

  it 'allows PNGs' do
    expect(FactoryGirl.build(:photo, image_content_type: "image/png")).to be_valid
  end

  it 'does not allow TIFs' do
    expect(FactoryGirl.build(:photo, image_content_type: "image/tif")).not_to be_valid
  end

  it 'rejects non-images' do
    expect(FactoryGirl.build(:photo, image_content_type: "text/xml")).not_to be_valid
  end


  describe '#url' do
    it 'returns the S3 url of the image' do
      expect(photo).to respond_to(:url)
    end
  end


end