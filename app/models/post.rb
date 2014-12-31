class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  has_many :likes,    as: :likable,     dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :author,  presence: true
  validates :content, presence: true,
                        length: { maximum: 255 }

  # load items for an index of posts with comments and likes
  def self.include_post_info
    includes( author: [profile: :photo], likes: :liker,
            comments: [:commentable, likes: :liker,
              author: [profile: :photo]])
  end

  def self.friends_posts(user)
    where(author_id: user.friends.pluck(:id) << user.id)
  end

  def self.recently_popular(user, period)
    friends_posts(user).
      where("created_at > ? AND likes_count > 2", Time.now - period).
      order(likes_count: :desc).
      limit(10)
  end
end
