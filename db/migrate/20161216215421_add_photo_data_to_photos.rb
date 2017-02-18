class AddPhotoDataToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_attachment :photos, :photo_data
  end
end
