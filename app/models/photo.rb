class Photo < ApplicationRecord
  attr_reader :image_remote_url
  has_attached_file :image, styles: { medium: '300x300', thumb: '100x100' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  belongs_to :user

  def picture_from_url(url)
    self.image = URI.parse(url)
  end
end
