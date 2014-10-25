module ApplicationHelper

	def check_login
		if current_user
			render 'shared/user_navbar'
		else
			render 'shated/home_navbar'
		end
	end

end
