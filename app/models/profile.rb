class Profile < ActiveRecord::Base

  belongs_to :user
  belongs_to :profile_photo, class_name: "Photo"
  belongs_to :cover_photo, class_name: "Photo"


  validates :about_me, :words_to_live_by, length: { maximum: 250 }
  validates :hometown, :current_city, length: { maximum: 70 }

  after_create :set_default_photo

  private

  def set_default_photo
    self.update(profile_photo: Photo.all.sample)
  end

end
