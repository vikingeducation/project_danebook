class Profile < ActiveRecord::Base
	belongs_to :user
	has_many :posts


# def home_city_and_country
# 	home_city + " " + home_country
# end

# def home_city_and_country=(home_city_and_country)
# 	full_home_location = home_city_and_country.split(" ")
# 	home_city = full_home_location.first
# 	home_country = full_home_location.last
# end

# def current_city_and_country
# 	current_city + " " + current_country
# end

end
