class Post < ActiveRecord::Base

  belongs_to :user

  has_many :likes, as: :likings, class_name: "Like", dependent: :destroy
  has_many :comments, as: :commentable, class_name: "Comment"

  validates :body, :user_id, :presence => :true



end
