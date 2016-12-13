class Post < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true

  has_many :likes, as: :likeable, dependent: :destroy 
  has_many :comments, as: :commentable, dependent: :destroy 
  validates :body, 
            length: { :minimum => 8 }
end
