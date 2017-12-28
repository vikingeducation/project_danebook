class AddColumnToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_attachment :photos, :avatar
  end
end
