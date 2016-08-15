class Comment < ActiveRecord::Base
  belongs_to :user

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  has_many :likes, as: :likeable

  accepts_nested_attributes_for :comments, :likes

  def liked?(user=nil)
    if user
      target = user.id
      likes.where(user_id: target).any?
    else
      likes.any?
    end
  end

  def like(user=nil)
    output = user ? likes.where(user_id: user.id) : likes
    output.last
  end

  
end
