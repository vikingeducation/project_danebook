module PostsHelper

	def new_post
		 render "post_form" if current_user?
	end

	def date_in_words(date)
		date.to_date.to_formatted_s(:long_ordinal)
		# date.strftime("%B %%d, %Y")
	end

	def delete_post(post)
		render "delete", post: post if current_user?
	end
end
