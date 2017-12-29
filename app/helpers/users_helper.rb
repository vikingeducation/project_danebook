module UsersHelper
  def get_cover_photo(user)
    img = ""
    if user.cover_photo_id.nil?
      img = "hogwarts_small.jpg"
    else
      if(user.photos != null)
        @photo = Photo.find(cover_photo_id)
        img = @photo.avatar.url
      end
    end
    img
  end

  #  def get_profile_photo(user)
  #   img = ""
  #   if user.profile_photo_id.nil?
  #     img = "harry_potter_small.jpg"
  #   else
  #     # if(user.photos)
  #       @photo = Photo.find(profile_photo_id)
  #       img = @photo.avatar.url
  #     # end
  #   end
  #   img
  # end

  def get_profile_photo(user)
    if photo = user.profile_photo 
      photo.avatar.url
    else
      "harry_potter_small.jpg"
    end
  end
end
