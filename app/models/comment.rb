class Comment < ActiveRecord::Base

	belongs_to :user
	belongs_to :commentable, :polymorphic => true

	# a comment can have comments
	has_many :comments, as: :commentable

	has_many :likes, as: :liking
	has_many :users_liking_comment, through: :likes, source: :user 

	validates :body, :user, presence: true
	validates :commentable, presence: true

	def count_likes
		users_liking_comment.count
	end

end
