module ProfilesHelper

  def profile_upload_form(form)
    image_upload_form(form, :profile_gallery, current_user.profile.profile_gallery.images.build)
  end

  def render_profile_img(profile)
    if Rails.configuration.aws_images && profile.profile_img
      profile.profile_img.picture.url(:medium) || "//s3.amazonaws.com/viking_education/web_development/web_app_eng/user_silhouette_generic.gif"
    else
      "//s3.amazonaws.com/viking_education/web_development/web_app_eng/user_silhouette_generic.gif"
    end
  end

  # def set_aws_options
  #   if Rails.configuration.aws_images
  #     s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{current_user.id}/images/original/#{SecureRandom.uuid}-${filename}", success_action_status: '201', acl: 'public-read')
  #     {'form-data' => (s3_direct_post.fields), 'url' => s3_direct_post.url, 'host' => URI.parse(s3_direct_post.url).host }
  #   end
  # end
end
