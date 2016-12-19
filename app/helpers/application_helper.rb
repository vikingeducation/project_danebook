module ApplicationHelper
   def set_cover_photo(user)
     if user.cover_photo
       user.cover_photo.expiring_url(3600, :original)
     else
       "https://s3.amazonaws.com/danebook191919/hogwarts_small.jpg"
     end
   end

   def set_avatar_photo(user)
     if user.profile_photo
       user.profile_photo.expiring_url(3600, :cover)
     else
       "https://s3.amazonaws.com/danebook191919/user_silhouette.png"
     end
   end

end
