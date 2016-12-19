module ApplicationHelper
  def render_nav_content
    if signed_in_user?
      render_user_nav
    else
      render_login_nav
    end
  end

  def render_user_nav
    render partial: 'shared/navbar/user'
  end

  def render_like(post)
    if post.liked_user_ids.include?(current_user.id)
      link_to "Unlike", like_path(post), method: :delete
    else
      link_to "Like", like_path(post), method: :put
    end
  end

  def render_notice_badge
    " <span class=\"badge\">#{current_user.notice_count}</span>".html_safe if current_user.notice_count > 0
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

  def render_profile_img(profile)
    if Rails.configuration.aws_images && profile.profile_img
      profile.profile_img.picture.url(:medium) || "//s3.amazonaws.com/viking_education/web_development/web_app_eng/user_silhouette_generic.gif"
    else
      "//s3.amazonaws.com/viking_education/web_development/web_app_eng/user_silhouette_generic.gif"
    end
  end

  def render_login_nav
    render partial: 'shared/navbar/anon'
  end

  def render_post_comments(post)
    comments = post.comments.select{|com| com.user }
    if comments.length > 0
      render partial: 'shared/posts/comments', locals: { comments: comments}
    end
  end

  def format_user_name(user)
     "#{user.profile.first_name} #{user.profile.last_name}"
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
end
