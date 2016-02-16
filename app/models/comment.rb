class Comment < ActiveRecord::Base
  
  belongs_to    :user
  belongs_to    :commentable, polymorphic: true

  has_many      :likes,    as: :likeable,    dependent:   :destroy
  has_many      :comments, as: :commentable, dependent:   :destroy
  has_many      :liked_by_users, through: :likes, source:   :liked_by

  validates_presence_of :body

  #validates :commentable_id, uniqueness: { scope: :commentable_type}

  def liked_by_user(user)
    like = self.likes.where("user_id = ?",user.id)
  end 

  def liked_by_other_users(liked_by_user)
    likes = self.liked_by_users.where("user_id != ?", liked_by_user)
  end
end
