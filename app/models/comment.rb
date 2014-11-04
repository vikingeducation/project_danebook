class Comment < ActiveRecord::Base

	belongs_to :commentable, polymorphic: true
	belongs_to :user

	validates :author_id, :body, presence: true
end
