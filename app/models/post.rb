class Post < ApplicationRecord

  validates :body, presence: true

  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  def like_list
    likes.map {|like| like.user.name}.join(", ")
  end

  def self.friend_posts(user)
    nil
    friend_ids = "(#{user.friended_ids.join(",")})"
    self.where("user_id IN #{friend_ids}").order("created_at DESC")
  end

end
