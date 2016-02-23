class Comment < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy


  validates :body, length: { in: 1..250 }, presence: true
  validates :user_id, uniqueness: { scope: [:commentable_id, :commentable_type]}, presence: true


end
