class AddToProfilePhotosJob < ApplicationJob
  queue_as :default

  def perform(image_id)
    # Do something later
    Image.find(image_id).copy_to_profile_photos
  end
end
