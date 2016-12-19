class Photo < ApplicationRecord
  has_attached_file :photo_data, styles: { medium: "600x600", thumb: "150x150" }
  validates_attachment_content_type :photo_data, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :owner, class_name: "User"
  has_one :profile_with_profile_pic, foreign_key: :profile_pic_id
  has_one :profile_with_cover_photo, foreign_key: :cover_photo_id
  has_many :likes, as: :likable_thing, dependent: :destroy

end
