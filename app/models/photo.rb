class Photo < ApplicationRecord

  has_attached_file :photo_data, styles: { cover: ["770x230#", :jpg], feed: ["350x250#", :jpg], tile: ["150x150#", :jpg], profile: ["150x150#", :jpg], thumb: ["35x35#", :jpg] },
      default_url: ":style_pic_missing.jpg"

  belongs_to :user
  has_one :profile_pic, class_name: :User, foreign_key: 'profile_pic_id'
  has_one :cover_pic, class_name: :User, foreign_key: 'cover_pic_id'

  include Liking
  include Commenting

  validates_attachment :photo_data, presence:  true,
    content_type: { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] },
    size: { in: 0..3.megabytes }

  def self.display_in_activity(users)
    where(user: users)
    .includes(:user,
      likes: [:user],
      comments: [:user,
        likes: [:user]])
    .order(created_at: :DESC)
  end


end
