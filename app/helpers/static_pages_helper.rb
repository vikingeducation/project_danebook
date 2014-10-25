#helpers/static_pages_helper.rb
module StaticPagesHelper

	def date_maker
		2014.downto(1900) do |yr|
			raw("\<option value\=\'#{yr}\'>#{yr}\<\/option\>")
		end
	end

end
