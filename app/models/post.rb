class Post < ActiveRecord::Base
  
  belongs_to :user
  has_many   :likes,    as: :likeable, dependent:   :destroy
  has_many   :comments, as: :commentable, dependent:   :destroy

  validates_presence_of :body

  #scope :user_posts, where("user_id = ?",id).order('id DESC')

  def liked_by_user(user)
    like = self.likes.where("user_id = ?",user.id)
  end 

  def liked_by_other_users(liked_by_user)
    likes = self.likes.where("user_id != ?", liked_by_user)
  end
end
