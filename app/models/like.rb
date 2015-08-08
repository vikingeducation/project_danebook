class Like < ActiveRecord::Base

	belongs_to :user
	belongs_to :liking, :polymorphic => true
	# user_id is unique for each post
	validates :user_id, :uniqueness => {:scope => [:liking_id, :liking_type]}
	# validates :post, :user, :presence => true
	validates :user, :presence => true

	def self.find_liked_object(object, current_user)
		Like.where(:liking_id => object.id).
				where(:liking_type => object.class).
				where(:user_id => current_user.id).first
	end

end
