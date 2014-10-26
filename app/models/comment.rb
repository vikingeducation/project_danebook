class Comment < ActiveRecord::Base

  belongs_to :user

  belongs_to :commentable, polymorphic: :true

  has_many :likes, as: :likable, dependent: :destroy
  has_many :users_who_liked, through: :likes, source: :user
end
