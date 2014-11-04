module ProfilesHelper

	def show_or_edit_profile
	end

	def only_user_sees(edit_path, user) # this is a terrible method name
		edit_path if (current_user == user)
	end

	def edit_link
		link_to "Edit profile", edit_user_profile_path, {class: "edit"}
	end

	def edit_button
		render 'edit_button'
	end

	def user_profile_name
		User.find(params[:user_id]).name
	end

	def user_exist?
		# check if the user_id in params before rendering profile page
	end
end
