class User < ApplicationRecord
  belongs_to :profile_pic, class_name: "Photo"
  belongs_to :cover_pic, class_name: "Photo"

  has_many :comments, dependent: :nullify

  has_many :postings, dependent: :destroy
  has_many :text_posts, through: :postings, source: :postable, source_type: "Post"
  has_many :photo_posts, through: :postings, source: :postable, source_type: "Photo"
end
