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
end
