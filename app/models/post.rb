class Post < ActiveRecord::Base
  has_many :comments, as: :commentable
  belongs_to :author, class_name: "User", foreign_key: :user_id
end
