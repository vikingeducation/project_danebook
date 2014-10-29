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
end
