require 'open-uri'

class Photo < ApplicationRecord

  has_attached_file :photo, styles: { large: '500x500', medium: '300x300', small: '100x100' }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user

  def self.reversed
    Photo.order(created_at: :desc)
  end

  def picture_from_url(url)
    self.picture = URI.parse(url)
  end

end
