module PostsHelper

	def new_post
		 render "post_form" if current_user?
	end

	def delete_post(post)
		render "delete", post: post if current_user?
	end

	def count_friends(user)
		user.friended_users.count
	end

end
