module CoverImagesHelper
  def cover_image(user)
    if user.cover_image_file_name.nil?
      image_tag("cover/cover.jpg", :alt => "cover photo", class: "cover-photo")
    else
      image_tag(user.cover_image.url(:medium), :alt => "cover photo", class: "cover-photo")
    end
  end
end
