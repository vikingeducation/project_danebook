class Post < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true

  has_many :likes, foreign_key: :post_id, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_one :image, dependent: :destroy

  has_many :comments, -> { order(:created_at) }, class_name: "Post", foreign_key: :post_id, dependent: :destroy

  validate :posting_on_friend

  def posting_on_friend
    unless post == nil || post.user.friend_ids.include?(user_id)
      errors.add(:post, :invalid, message: "- You can only post to you own or your friends' posts")
    end
  end

  default_scope {
    includes :user
  }
end
