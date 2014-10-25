class Post < ActiveRecord::Base

  belongs_to :user
  has_many :likes, as: :likable
  has_many :users_who_liked, through: :likes, source: :user

end
