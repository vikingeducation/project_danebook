module LikesHelper

	def show_like_or_unlike(liking)
		if post.user_likes_post?(liking.id, liking.type, current_user)
			show_unlike(Like.find_liked_post(liking.id, liking.type, current_user)) 
		else
			show_like(liking)
		end
	end

	def show_unlike(like) 
		link_to("Unlike", user_like_path(:id => like.id, :user_id => current_user.id), method: :delete)
	end

	def show_like(liking)
		link_to("Like", user_likes_path(:like => {:user_id => current_user.id, 
																							:liking_id => liking.id,
																							:liking_type => liking.class,
																							}), method: :post)
	end

end
