class Post < ActiveRecord::Base

  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  has_many :users_who_liked, through: :likes, source: :user

  has_many :comments, as: :commentable
  has_many :users_who_commented, through: :comments, source: :user

  validates_presence_of :body, :user
  validates :body, length: { maximum: 1000 }


  # arbitrarily returns most recent 13 posts in newsfeed
  # TODO: replace with pagination and/or infinite scroll
  def self.newsfeed_for(user)
    where("user_id IN (?)", user.friends.pluck(:id)).
    order("created_at DESC").
    limit(13)
  end

end
