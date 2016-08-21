class Post < ApplicationRecord
  has_many :comments, :as => :commentable
  has_many :commenters, through: :comments, source: :user
end
