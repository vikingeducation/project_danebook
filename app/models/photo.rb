class Photo < ApplicationRecord

  has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "100x100" }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  
  has_one :cover_photo, class_name: "Photo", foreign_key: :cover_photo_id
  has_one :profile_photo, class_name: "Photo", foreign_key: :profile_photo_id

  belongs_to :profile


  def self.newest_six(profile)
    profile.photos.order("created_at DESC").take(6)
  end

end
