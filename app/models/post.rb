class Post < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy

  validates :content, :user, :presence => true

  def self.newsfeed(user)
    where("user_id IN (?)", user.all_friends.pluck(:id)).
    order("created_at DESC").
    limit(5)
  end

end
