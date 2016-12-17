require 'open-uri'

class Photo < ApplicationRecord

  belongs_to :user

  has_one :profile, foreign_key: :photo_id

  has_one :profile, foreign_key: :cover_photo_id

  has_many :comments, as: :commentable, dependent: :destroy
  
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_attached_file :photo, styles: { large: '500x500', medium: '300x300', small: '100x100' }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def self.reversed
    Photo.order(created_at: :desc)
  end

  def picture_from_url(url)
    self.picture = URI.parse(url)
  end

  def total_likes
    likes.count
  end

  def last_nine_photos
    Photo.order(created_at: :desc).limit(9)
  end

  def random_liker
    likers.sample.full_name
  end

end
