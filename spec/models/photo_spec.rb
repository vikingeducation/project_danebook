require 'rails_helper'

describe Photo do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:profile_photo){create(:profile_photo, :user => user)}
  let(:cover_photo){create(:cover_photo, :user => user)}
  let(:other_photo){create(:other_photo, :user => user)}
  let(:other_photo_comment){create(:photo_comment, :user => user, :commentable => other_photo)}
  let(:other_photo_like){create(:photo_like, :user => user, :likeable => other_photo)}

  describe '#user' do
    it 'returns the user to whom this photo belongs' do
      expect(other_photo.user).to eq(user)
    end
  end

  describe '#comments' do
    it 'returns the comments for this photo' do
      other_photo
      other_photo_comment
      expect(other_photo.comments.first).to eq(other_photo_comment)
    end
  end

  describe '#likes' do
    it 'returns the likes for this photo' do
      other_photo
      other_photo_like
      expect(other_photo_like).to eq(other_photo_like)
    end
  end

  describe '#file' do
    it 'returns the file object for this photo' do
      expect(other_photo.file).to be_an_instance_of(Paperclip::Attachment)
    end
  end

  describe 'validates' do
    describe 'user' do
      it 'is present' do
        expect {create(:other_photo, :user => nil)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '#destroy' do
    it 'nullifies the profile photo on the user when it is set to this photo' do
      user.update!(:profile_photo => profile_photo)
      profile_photo.destroy!
      expect(user.profile_photo).to eq(nil)
    end

    it 'nullifies the cover photo on the user when it is set to this photo' do
      user.update!(:cover_photo => cover_photo)
      cover_photo.destroy!
      expect(user.cover_photo).to eq(nil)
    end
  end
end





