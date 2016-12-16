class Photo < ApplicationRecord
  belongs_to :user
  has_attached_file :picture, styles: {
  thumb: "100x100", small: "200x200" }

  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/


end
