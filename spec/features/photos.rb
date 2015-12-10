require 'rails_helper'

describe 'Photos' do
  describe 'listing' do
    it 'displays all photos for a user'
  end

  describe 'showing' do
    it 'displays a single photo'
    it 'provides a like form'
    it 'provides a comment form'

    context 'the photo belongs to the current user' do
      it 'displays a link to set the photo to the profile photo'
      it 'displays a link to set the photo to the cover photo'
      it 'displays a link to delete the photo'
    end
  end

  describe 'setting the profile photo' do
    it 'results in the profile photo being set to the photo'
  end

  describe 'setting the cover photo' do
    it 'results in the cover photo being set to the photo'
  end

  describe 'deleting' do
    it 'results in the photo being destroyed'
  end
end


