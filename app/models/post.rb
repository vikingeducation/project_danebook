class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id

  has_many :likes, as: :likeable
  has_many :comments, as: :commentable
end
