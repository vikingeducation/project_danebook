class Photo < ApplicationRecord
  attr_reader :image_remote_url
  has_attached_file :image, styles: { medium: '300x300', thumb: '100x100' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  belongs_to :user
  has_one :profile_photo_user, class_name: 'User', foreign_key: :profile_photo_id
  has_one :cover_photo_user, class_name: 'User', foreign_key: :cover_photo_id
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  def picture_from_url(url)
    self.image = URI.parse(url)
  end
end
