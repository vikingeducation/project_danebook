class Post < ActiveRecord::Base
	# post belongs_to :profile
	belongs_to :user
	
	# likes are polymorphic
	has_many :likes, as: :liking
	has_many :liked_by, through: :likes, source: :user
	
	# comments are polymorphic
	has_many :comments, as: :commentable

	def count_likes(id)
		Post.find(id).likes.count
	end

	def user_likes_post?(post_id, current_user)
		Post.find(post_id).liked_by.ids.include?(current_user.id)
	end

	def self.all_users_liking_post(post_id, current_user)
		find(post_id).liked_by.select(:id, :first_name)
	end

end
