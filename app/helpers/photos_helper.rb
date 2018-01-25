module PhotosHelper

  def display_photo_like_unlike(photo)
    if current_user.photos_they_like.include?(photo)
      like = Like.current_user_like(photo, current_user)
      link_to 'Unlike', user_photo_like_path(id: like, photo_id: photo.id, likeable: 'Photo'), method: :delete
    else
      link_to 'Like', user_photo_likes_path(photo_id: photo.id, likeable: 'Photo'), method: :post
    end
  end

end
