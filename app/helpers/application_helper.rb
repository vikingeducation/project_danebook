module ApplicationHelper

	def check_login
		if current_user
			render 'shared/user_navbar'
		else
			render 'shared/home_navbar'
		end
	end

	def minutes_since_creation(object)
		end_of_minute(Time.now - object.created_at)
	end

	def date_in_words(date)
		date.to_date.to_formatted_s(:long_ordinal)
		# date.strftime("%B %%d, %Y")
	end

	def build_comment(type)
		type.comments.build
	end
end
