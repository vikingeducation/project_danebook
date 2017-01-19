class AutoPoster
  class << self
    include ActionView::Helpers::UrlHelper
    include ActionView::Helpers::AssetTagHelper

    def new_image(img)
      body = "<p class=\"text-center\">#{image_tag(img.picture.url(:original))}</p>"
      post = Post.create(post_type: "Image", body: body, user: img.user)
      img.post = post
      img.save
    end

  end
end
