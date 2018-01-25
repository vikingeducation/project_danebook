class Photo < ApplicationRecord

  has_attached_file :photo_data, styles: { cover: ["770x230#", :jpg], feed: ["350x250#", :jpg], tile: ["150x150#", :jpg], profile: ["150x150#", :jpg], thumb: ["35x35#", :jpg] },
      default_url: ":style_pic_missing.jpg"

  belongs_to :user
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable

  validates_attachment :photo_data, presence:  true,
    content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
    size: { in: 0..2.megabytes }

  def has_likes?
   likes.any?
  end

  def has_comments?
    comments.any?
  end
end
