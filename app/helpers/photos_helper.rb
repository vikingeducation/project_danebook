module PhotosHelper

    #Get the picture from a given url.
  def picture_from_url(url)
      self.picture = open(url)
  end
end
