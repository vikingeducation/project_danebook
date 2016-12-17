class Photo < ApplicationRecord
  has_attached_file :photo_data, styles: { medium: "600x600", thumb: "150x150" }
  validates_attachment_content_type :photo_data, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :owner, class_name: "User"

end
