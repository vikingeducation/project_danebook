class Post < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true

  has_many :likes, foreign_key: :post_id, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :comments, -> { order(:created_at) }, class_name: "Post", foreign_key: :post_id, dependent: :destroy

  default_scope {
    includes :user
  }
end
