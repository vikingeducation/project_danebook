class AddPhotoDataColumnToPhotos < ActiveRecord::Migration
  def change
    add_attachment :photos, :photo_data
  end
end
