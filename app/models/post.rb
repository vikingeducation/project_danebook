class Post < ActiveRecord::Base

	belongs_to :user

	# has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

end