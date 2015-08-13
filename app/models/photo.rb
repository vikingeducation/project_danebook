require 'open-uri'

class Photo < ActiveRecord::Base

  has_attached_file :image,
                    styles: { large: "700x700",
                              medium: "300x300",
                              thumb: "100x100" },
                    default_url: "/images/:style/missing.png"
  belongs_to :user
  has_one :profile
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :liking, dependent: :destroy
  has_many :users_liking_photos, through: :likes, source: :user

  validates_attachment_content_type :image,
                                    content_type: /\Aimage\/.*\Z/


  def image_from_url(url)
    self.image = open(url) unless url.nil?
  end

  def count_likes
    users_liking_photos.count
  end


end
