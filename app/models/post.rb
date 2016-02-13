class Post < ActiveRecord::Base

  belongs_to :user
  has_many :likes, as: :likeable
  has_many :comments

  validates :body, :user_id, presence: true
  validates :body, length: { in: 1..250 }





end
