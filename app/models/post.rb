class Post < ActiveRecord::Base
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  accepts_nested_attributes_for :comments, :likes, allow_destroy: true

  def liked?(user)
    target = user.id
    likes.where(user_id: target).any?
  end

  def like(user=nil)
    output = user ? likes.where(user_id: user.id) : likes
    output.last
  end

end
