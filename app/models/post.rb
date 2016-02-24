class Post < ActiveRecord::Base
  
  belongs_to :user
  has_many   :likes,    as: :likeable,    dependent:   :destroy
  has_many   :liked_by_users, through: :likes, source: :liked_by

  has_many   :comments, -> { order('created_at ASC') }, as: :commentable, dependent:   :destroy
  
  # belongs_to :posted_by_friend, class_name: "Friendship", 
  #            foreign_key: "friend_receiver_id" 

  validates_presence_of :body
  validates :user, presence: true

  def liked_by_user(user)
    like = self.likes.where("user_id = ?",user.id)
  end 

  def liked_by_other_users(liked_by_user)
    likes = self.liked_by_users.where("user_id != ?", liked_by_user)
  end

  def self.newsfeed_for_user(user_id)
    Post.select("posts.id,posts.body, posts.user_id, posts.created_at").
    joins("JOIN friendships AS f ON f.friend_receiver_id = posts.user_id").
    where("f.friend_requestor_id = ?", user_id).
    order("posts.id")
  end  
end
