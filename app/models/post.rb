class Post < ActiveRecord::Base
	# post belongs_to :profile
	belongs_to :user
	
	# likes are polymorphic
	has_many :likes, as: :liking
	has_many :liked_by, through: :likes, source: :user
	
	# comments are polymorphic
	has_many :comments, as: :commentable

	validates :body, :user_id, :presence => true
	validates :body, :length => {:in => 1..250}

	def count_likes
		likes.count
	end

	def user_likes_post?(current_user)
		liked_by.include?(current_user)
	end

	def self.all_users_liking_post(post_id, current_user)
		find(post_id).liked_by.select(:id, :first_name)
	end

end
