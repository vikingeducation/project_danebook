class Photo < ApplicationRecord
  has_many :postings, as: :postable
  has_many :comments, :as => :commentable
  has_many :commenters, through: :comments, source: :user
  has_many :users
end
