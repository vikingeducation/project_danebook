module PhotosHelper

  def profile_photo(id:, size: :medium, styling: '')
    if profile_photo = User.find(id).profile_photo
      image_tag profile_photo.expiring_url(3600, size),
        class: styling
     else
      default_picture(size, styling)
    end
  end

  def default_picture(size, styling)
    size = size_for(size)
    image_tag 'user_silhouette_generic.png',
    style: "max-height: #{size}"
  end

    def photo_count(user_id)
      Photo.where(user_id: user_id).count
    end

  def cover_photo_link(user_id, photo)
     if current_user.id == user_id && current_user.cover_photo != photo
       create_cover_photo_link(current_user, photo.id)
     end
   end
 
   def profile_photo_link(user_id, photo)
     if current_user.id == user_id && current_user.profile_photo != photo
       create_profile_photo_link(current_user, photo.id)
      end
    end

    def create_profile_photo_link(user, photo_id)
     link_to "Make Profile Photo",
       user_profile_path(user, profile: { id: user.profile.id,
                                          profile_photo_id: photo_id }),
                                          method: :patch
   end
 
   def create_cover_photo_link(user, photo_id)
     link_to "Make Cover Photo",
       user_profile_path(user, profile: { id: user.profile.id,
                                          cover_photo_id: photo_id }),
                                          method: :patch
   end
 
  def size_for(size)
     if size == :tiny
       '65px'
     elsif size == :thumb
       '85px'
    elsif size == :small
       '150px'
     elsif size == :medium
       '200px'
      end
    end
end
