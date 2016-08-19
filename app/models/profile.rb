class Profile < ApplicationRecord
  belongs_to :user
  
  belongs_to :cover_photo, class_name: "Photo", foreign_key: :cover_photo_id, optional: true
  belongs_to :profile_photo, class_name: "Photo", foreign_key: :profile_photo_id, optional: true

  

  
end
