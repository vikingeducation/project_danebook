class Profile < ActiveRecord::Base
  belongs_to :user

  def profile_photo
    profile_photo_id = self.profile_photo_id
    Photo.find(profile_photo_id)
  end

  def cover_photo
    cover_photo_id = self.cover_photo_id
    Photo.find(cover_photo_id)
  end


end
