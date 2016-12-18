class Photo < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_attached_file :file, styles: { cover: "800x450>", medium: "200x200>",
                                     small: "125x125>", thumb: "100x100>",
                                     tiny: "65x65>" }
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy 
  has_many :likers, through: :likes, source: :user

  def expiring_url(time, size)
    file.expiring_url(time, size)
  end

  def url(size)
    file.url(size)
  end


end
