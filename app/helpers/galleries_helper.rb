module GalleriesHelper
  def gallery_cover(gallery)
    gallery.images.size == 0 ? (image_tag "//s3.amazonaws.com/viking_education/web_development/web_app_eng/user_silhouette_generic.gif") : (image_tag gallery.images.first.picture.url(:medium))
  end

  # def set_aws_options
  #   if Rails.configuration.aws_images
  #     s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{current_user.id}/images/original/#{SecureRandom.uuid}-${filename}", success_action_status: '201', acl: 'public-read')
  #     {'form-data' => (s3_direct_post.fields), 'url' => s3_direct_post.url, 'host' => URI.parse(s3_direct_post.url).host }
  #   end
  # end
end
