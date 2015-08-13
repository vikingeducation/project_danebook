class Profile < ActiveRecord::Base

	belongs_to :user
	has_many :posts
  belongs_to :profile_photo, class_name: 'Photo'
  # accepts_nested_attributes_for :profile_photo
  belongs_to :cover_photo, class_name: 'Photo'
  # accepts_nested_attributes_for :cover_photo

  # after_create :set_default_photos

private

  def set_default_photos
    update(profile_photo: Photo.first, cover_photo: Photo.second)
  end

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
