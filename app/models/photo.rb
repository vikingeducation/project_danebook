class Photo < ApplicationRecord

  has_attached_file :image

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  attr_accessor :delete_image

  belongs_to :user

  has_one :profile_photo_user, foreign_key: :picture_id, class_name: "Profile"
  has_one :cover_photo_user, foreign_key: :cover_id, class_name: "Profile"

  has_many :likes, as: :likable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :comments, as: :commentable
  has_many :commenters, through: :comments, source: :user

  def image_from_url(url)
    self.image = open(url)
  end

  #def photo_data=(photo_data)
  #  self.data      = photo_data.read
  #  self.filename  = photo_data.original_filename
  #  self.mime_type = photo_data.content_type
  #end

end
