module PostsHelper

	# Returns the names of two others who like the post
	def other_users_liking_post(post_id)
		users_liking_post = Post.all_users_liking_post(post_id, current_user)
		first_liker = nil
		second_liker = nil

		# Do not return the username of the current user
		if users_liking_post.ids.count == 1
			first_liker = users_liking_post.first.first_name if users_liking_post.first.id != current_user.id
		
		elsif users_liking_post.ids.count == 2
				users_liking_post.first.id == current_user.id ? 
				first_liker = users_liking_post.second.first_name :
				first_liker = users_liking_post.first.first_name 
		
		elsif users_liking_post.ids.count > 2
			users_liking_post.first.id == current_user.id ? 
					first_liker = users_liking_post.third.first_name :
					first_liker = users_liking_post.first.first_name 

			users_liking_post.second.id == current_user.id ?
					second_liker = users_liking_post.third.first_name :
					second_liker = users_liking_post.second.first_name
		end

		[first_liker, second_liker]
	
	end

	# returns string of names to display who have liked a post
	def names_to_display(id)
		str = ""
		num_of_likes = Post.find(id).count_likes(id)
		like_or_likes = num_of_likes

		# add people other than current user
		other_likers = other_users_liking_post(id)
		if other_likers	
				str += " #{other_likers.first}" unless other_likers.first.nil?
				str += " and #{other_likers.second}" unless other_likers.second.nil?
		end

		# add current user
		if Post.find(id).user_likes_post?(id, current_user) 
			if like_or_likes > 1
				str = "You and" + str 
			elsif like_or_likes > 0
				str = "You " + str 
			end
		end

		# add number of likes
		num_of_likes - 2 < 0 ? num_of_likes = 0 : num_of_likes -= 2
		str += " and #{num_of_likes} others" if num_of_likes > 0 

		# add like or likes to the end
		if like_or_likes > 1 || Post.find(id).user_likes_post?(id, current_user) 
		 	str += " like this post" 
		elsif like_or_likes > 0 
		 	str += " likes this post"
		end
	
	end

end
