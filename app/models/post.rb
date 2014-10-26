class Post < ActiveRecord::Base

  belongs_to :user
  has_many :likes, as: :likable
  has_many :users_who_liked, through: :likes, source: :user

  has_many :comments, as: :commentable
  has_many :users_who_commented, through: :comments, source: :user

end
