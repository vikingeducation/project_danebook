class Like < ActiveRecord::Base

	belongs_to :user
	belongs_to :likings, :polymorphic => true
	# user_id is unique for each post
	validates :user_id, :uniqueness => {:scope => :post_id}
	# validates :post, :user, :presence => true
	validates :user, :presence => true

	def self.find_liked_post(post_id, current_user)
		Like.where(:post_id => post_id).where(:user_id => current_user).first
	end

end
