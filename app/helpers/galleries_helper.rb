module GalleriesHelper
  def gallery_cover(gallery)
    gallery.images.size == 0 ? (image_tag "//s3.amazonaws.com/viking_education/web_development/web_app_eng/user_silhouette_generic.gif") : (image_tag gallery.images.first.picture.url(:medium))
  end

  def render_gallery_image(photo)
    if Rails.configuration.aws_images
      if photo.post
        link_to user_post_path(photo.gallery.user, photo.post) do
          image_tag photo.picture.url(:medium)
        end
      else
        image_tag photo.picture.url(:medium)
      end
    else
      "//s3.amazonaws.com/viking_education/web_development/web_app_eng/user_silhouette_generic.gif"
    end
  end

  def image_upload_form(form, gallery, build = nil)
    if Rails.configuration.aws_images
      "
        <div class=\"alert alert-block alert-info\">
          <p><strong>(If you both choose an image and enter a Url, the Url will take precedence and selected image will be discarded)</strong></p>
        </div>
        #{render_image_upload(form, gallery, build)}
      ".html_safe
    else
      "<h4>Image Uploading disabled by admin</h4>".html_safe
    end
  end

  def render_image_upload(form, gallery, build)
      form.fields_for gallery do |gf|
        if defined?(build)
          gf.fields_for :images, build do |gif|
            render partial: 'shared/forms/img_upload_form' , locals: { form: gif }
          end
        else
          gf.fields_for :images do |gif|
            render partial: 'shared/forms/img_upload_form' , locals: { form: gif }
          end
        end
      end
  end
  # def set_aws_options
  #   if Rails.configuration.aws_images
  #     s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{current_user.id}/images/original/#{SecureRandom.uuid}-${filename}", success_action_status: '201', acl: 'public-read')
  #     {'form-data' => (s3_direct_post.fields), 'url' => s3_direct_post.url, 'host' => URI.parse(s3_direct_post.url).host }
  #   end
  # end
end
