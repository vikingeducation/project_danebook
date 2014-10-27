class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :likers, :through => :likes, :source => :user

  has_many :comments, :as => :commentable
  has_many :commenters, :through => :comments, :source => :user

end