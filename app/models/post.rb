class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable,  dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :comment_likes, through: :comments, source: :likes
  has_one :activity, as: :activable, dependent: :destroy
  validates :body, presence: true
  validates :user, presence: true
  after_create :create_activity_feed_record

  include Reusable

  def self.newsfeed_posts(user=nil)
    return nil unless user
    friend_ids = user.friendee_ids.clone
    Post.order('created_at DESC').where('user_id IN (?)', friend_ids << user.id).includes(user: [:profile])
  end

end
