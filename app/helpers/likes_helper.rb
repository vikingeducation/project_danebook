module LikesHelper

	def show_like_or_unlike(object)
		like_object = Like.find_liked_object(object, current_user)
		if like_object
			show_unlike(like_object) 
		else
			show_like(object)
		end
	end

	def show_unlike(like) 
		link_to("Unlike", user_like_path(:id => like.id, :user_id => current_user.id), method: :delete)
	end

	def show_like(object)
		link_to("Like", user_likes_path(:like => {:user_id => current_user.id, 
																							:liking_id => object.id,
																							:liking_type => object.class,
																							}), method: :post)
	end

end
