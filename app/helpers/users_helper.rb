module UsersHelper
  def get_cover_photo(user)
    if photo = user.cover_photo 
      photo.avatar.url
    else
      "hogwarts_small.jpg"
    end
  end
  
  def get_profile_photo(user)
    if photo = user.profile_photo 
      photo.avatar.url
    else
      "harry_potter_small.jpg"
    end
  end
end
