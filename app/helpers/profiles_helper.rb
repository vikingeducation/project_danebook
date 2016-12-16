module ProfilesHelper
  def background_image(profile)
    "style='background-image: url(\"#{@profile.background.expiring_url}\")'".html_safe if @profile.background
  end
end
