class Like < ActiveRecord::Base

	belongs_to :likeable, polymorphic: true
	belongs_to :user

	validates :user, :likeable_type, presence: true
	validates :likeable_type, inclusion:  ['Photo', 'Comment', 'Post']

end