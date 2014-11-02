module FriendingsHelper

	def friending_button
		if current_user.friended_users.pluck(:id).include?(@user.id)
		  link_to "Unfriend #{@user.name}",
		        user_friending_path(id: @user.id),
		        :method => "DELETE"
		else

		  link_to "Friend #{@user.name}",
		        user_friendings_path(id: @user.id),
		        :method => "POST"
		end
	end

end
