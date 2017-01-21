module ProfilesHelper

  def display_profile_photo(user, size)
    if user.profile.profile_photo
      image_tag user.profile.profile_photo.photo.url(size.to_sym), class: 'img-thumbnail img-responsive'.html_safe
    else
      image_tag 'harry_potter_small.jpg', class: 'img-thumbnail img-responsive'.html_safe
    end
  end

  def display_cover_photo(user)
    if user.profile.cover_photo
      user.profile.cover_photo.photo.url(:large).html_safe
    else
      '/assets/hogwarts_small.jpg'.html_safe
    end
  end    
  
end
