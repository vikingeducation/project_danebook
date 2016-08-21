class User < ApplicationRecord
  belongs_to :profile_pic, class_name: "Photo", optional: true
  belongs_to :cover_pic, class_name: "Photo", optional: true

  has_one :profile, dependent: :destroy

  has_many :comments, dependent: :nullify

  has_many :postings, dependent: :destroy
  has_many :text_posts, through: :postings, source: :postable, source_type: "Post"
  has_many :photo_posts, through: :postings, source: :postable, source_type: "Photo"

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :likeable, source_type: "Post"
  has_many :liked_comments, through: :likes, source: :likeable, source_type: "Comments"

  has_many :initiated_friendings, :foreign_key => :friender_id, :class_name => "Friending"
  has_many :friended_users, through: :initiated_friendings, source: :friend_recipient

  has_many :received_friendings, :foreign_key => :friend_id, :class_name => "Friending"
  has_many :users_friended_by, through: :received_friendings, source: :friend_initiator

  after_create :create_profile

  has_secure_password
end
