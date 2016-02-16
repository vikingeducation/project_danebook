class Post < ActiveRecord::Base
  
  belongs_to :user
  has_many   :likes,    as: :likeable,    dependent:   :destroy
  has_many   :liked_by_users, through: :likes, source: :liked_by

  has_many   :comments, -> { order('created_at ASC') }, as: :commentable, dependent:   :destroy

  validates_presence_of :body


  def liked_by_user(user)
    like = self.likes.where("user_id = ?",user.id)
  end 

  def liked_by_other_users(liked_by_user)
    likes = self.liked_by_users.where("user_id != ?", liked_by_user)
  end
end
