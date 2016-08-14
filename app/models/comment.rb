class Comment < ActiveRecord::Base
  belongs_to :user

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  has_many :likes, as: :likeable

  accepts_nested_attributes_for :comments, :likes

  def liked?(user)
    target = user.id
    likes.where(user_id: target).any?
  end

  def like(user)
    likes.where(user_id: user.id).last
  end
  
end
