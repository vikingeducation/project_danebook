class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  validates_presence_of :user, :post, :content
  validates :content, length: { :in => 1..300 }
end
