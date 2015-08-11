module UserMacros

	def fill_sign_up_form(**args)
		visit root_path
		fill_in 'user_first_name', with: args[:first_name] || "James"
		fill_in 'user_last_name', with: args[:last_name] || "Bond"
		fill_in 'user_email', with: args[:email] || "j@b.com"
		fill_in 'user_password', with: args[:pwd] || "1234567"
		fill_in 'user_password_confirmation', with: args[:pwd_confirmation] || "1234567"
	end

	def sign_in
		visit root_path
		fill_in 'email', with:  user.email
		fill_in 'password_digest', with: user.password
		click_button 'Log In'
	end

	def controller_sign_out
		session.delete(:user_id)
	end

	def controller_sign_in
		session[:user_id] = user.id
	end

end


