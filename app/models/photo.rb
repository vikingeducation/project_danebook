class Photo < ApplicationRecord

  has_attached_file :photo, styles: { medium: "300x300", thumb: "100x100" }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  belongs_to :user

  has_many :likes, as: :likable
  has_many :user_likes, through: :likes, source: :user


end
