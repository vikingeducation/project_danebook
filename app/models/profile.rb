class Profile < ActiveRecord::Base

  belongs_to :user
  has_one :profile_photo
  has_one :cover_photo


  validates :about_me, :words_to_live_by, length: { maximum: 250 }
  validates :hometown, :current_city, length: { maximum: 70 }

end
