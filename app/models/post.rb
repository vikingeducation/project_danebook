class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, :as => :likeable
  has_many :likers, through: :likes, source: :user
  has_many :comments, :as => :commentable
  has_many :commenters, through: :comments, source: :user
  has_many :postings, as: :postable


  validates :description,
            :length => {in: 1..800}

  def self.to_s
    "post"
  end

  def to_s
    "posts"
  end

  def self.activity(users_friends)
    joins("JOIN postings ON postings.postable_id = posts.id").where(postings: {postable_type: "Post", user_id: [users_friends]})
  end
end
