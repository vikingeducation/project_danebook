#helpers/static_pages_helper.rb
module StaticPagesHelper
	def check_for_home_and_put_sign_in
		if current_page?(root_path)
			render "shared/home_navbar"
		else
			render "shared/user_navbar"
		end
	end
end
