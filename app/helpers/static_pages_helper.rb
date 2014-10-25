#helpers/static_pages_helper.rb
module StaticPagesHelper
	def check_for_home_and_put_sign_in
		if current_page?(root_path)
			render "shared/home_navbar"
		else
			render "shared/user_navbar"
		end
	end

	def date_maker
		2014.downto(1900) do |yr|
			raw("\<option value\=\'#{yr}\'>#{yr}\<\/option\>")
		end
	end
end
