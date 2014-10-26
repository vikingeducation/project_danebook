class Comment < ActiveRecord::Base

  belongs_to :user

  belongs_to :commentable, polymorphic: :true

  has_many :likes, as: :likable
  has_many :users_who_liked, through: :likable, source: :user
end
