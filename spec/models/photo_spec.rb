require 'rails_helper'

describe Photo do
  it_behaves_like 'Dateable'
  it_behaves_like 'Feedable'

  describe '#user' do
    it 'returns the user to whom this photo belongs'
  end

  describe '#comments' do
    it 'returns the comments for this photo'
  end

  describe '#likes' do
    it 'returns the likes for this photo'
  end

  describe '#file' do
    it 'returns the file object for this photo'
  end

  describe 'validates' do
    describe 'user' do
      it 'is present'
    end

    describe 'file' do
      it 'is present'
      it 'has an image content type'
      it 'is between 0 and 2 megabytes'
    end
  end

  describe '#destroy' do
    it 'nullifies the profile photo on the user when it is set to this photo'
    it 'nullifies the cover photo on the user when it is set to this photo'
  end
end

