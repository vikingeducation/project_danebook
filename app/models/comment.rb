class Comment < ActiveRecord::Base

	belongs_to :user
	belongs_to :commentable, :polymorphic => true

	# a comment can have comments
	has_many :comments, as: :commentable


end
