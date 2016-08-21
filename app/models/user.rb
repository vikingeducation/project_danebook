class User < ApplicationRecord
  belongs_to :profile_pic, class_name: "Photo"
  belongs_to :cover_pic, class_name: "Photo"

  has_many :comments, dependent: :nullify

  has_many :postings, dependent: :destroy
  has_many :text_posts, through: :postings, source: :postable, source_type: "Post"
  has_many :photo_posts, through: :postings, source: :postable, source_type: "Photo"

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :likeable, source_type: "Post"
  has_many :liked_comments, through: :likes, source: :likeable, source_type: "Comments"
end
