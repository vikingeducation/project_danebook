class Comment < ActiveRecord::Base
  belongs_to :user

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  has_many :likes, as: :likeable

  accepts_nested_attributes_for :comments, :likes
end
