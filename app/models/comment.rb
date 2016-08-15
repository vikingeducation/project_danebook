class Comment < ApplicationRecord
  #belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable, dependent: :nullify

  accepts_nested_attributes_for :comments
end
