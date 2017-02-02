class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy

  validates :content, :user, :presence => true
end
