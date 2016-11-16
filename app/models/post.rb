class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
  has_many :likes, as: :likeable
  has_many :comments, :as => :commentable

  accepts_nested_attributes_for :comments

  def posted_date
    updated_at.strftime("%A %m/%d/%Y")
  end
  
  def self.newsfeed_posts(friends)
    where("user_id IN (?)", friends).order(updated_at: :desc)
  end

end
