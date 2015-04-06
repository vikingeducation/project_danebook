class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments
end
