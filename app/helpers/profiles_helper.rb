module ProfilesHelper

  def profile_upload_form(form)
    image_upload_form(form, :profile_gallery, current_user.profile.profile_gallery.images.build)
  end

  # def set_aws_options
  #   if Rails.configuration.aws_images
  #     s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{current_user.id}/images/original/#{SecureRandom.uuid}-${filename}", success_action_status: '201', acl: 'public-read')
  #     {'form-data' => (s3_direct_post.fields), 'url' => s3_direct_post.url, 'host' => URI.parse(s3_direct_post.url).host }
  #   end
  # end
end
