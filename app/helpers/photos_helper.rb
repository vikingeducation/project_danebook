module PhotosHelper
	def image_or_linked_image(photo, user)
		if user.friended_by?(current_user) || user == current_user
			link_to photo_path(photo) do
				image_tag photo.data.url(:medium), class: "img-responsive"
			end
		else
			image_tag photo.data.url(:medium), class: "img-responsive"
		end
	end

  def profile_pic_if_avail(photo)
    image_tag photo.user.profile_pic ? photo.user.profile_pic.data.url(:thumb) : "user_silhouette_generic.gif"
  end

  def photo_owner_options(photo)
    if @photo.user == current_user
      ("<p> " +
      "#{link_to "Set as Profile", photo_set_as_profile_path(photo_id: @photo.id), method: :post}" +
      "</p> " +
      "<p> " +
      "#{link_to "Set as Cover", photo_set_as_cover_path(photo_id: @photo.id), method: :post}" +
      "</p> " +
      "<p> " +
      "#{link_to "Delete Photo", photo_path(@photo), method: :delete, class: "text-danger", data: {confirm: "Are you sure you want to delete this photo?"}}" +
      "</p> ").html_safe
    end
  end

  def link_to_all_photos(user)
    link_to "See more photos!", user_photos_path(user) if user.photos.count > 3
  end


end
