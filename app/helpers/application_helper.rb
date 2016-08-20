module ApplicationHelper

  def errors(obj)
    if obj
      obj.errors.full_messages.each do |msg|
        msg
      end
    end
  end

def profile_image(user)
  if user.profile.profile_photo_id
    image_tag User.get_profile_photo(user).image.url, class:"profile"
  else
    image_tag 'user_silhouette_generic.gif', class:"profile"
  end
end

def cover_image(user)
  if user.profile.cover_id
    image_tag User.get_cover_photo(user).image.url
  else
    image_tag 'hogwarts_small.jpg'
  end
end

end
