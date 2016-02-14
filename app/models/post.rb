class Post < ActiveRecord::Base

  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :body, :user_id, presence: true
  validates :body, length: { in: 1..250 }





end
