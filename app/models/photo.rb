class Photo < ApplicationRecord
  has_many :users

  has_many :postings, as: :postable

  has_many :comments, :as => :commentable
  has_many :commenters, through: :comments, source: :user

  has_many :likes, :as => :likeable
  has_many :likers, through: :likes, source: :user

end
