class Photo < ApplicationRecord

  has_attached_file :photo, styles: { large: "400x400", medium: "200x200", thumb: "50x50" }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  belongs_to :user

  has_many :likes, as: :likable, dependent: :destroy
  has_many :user_likes, through: :likes, source: :user, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :user_comments, through: :comments, source: :user, dependent: :destroy 


end
