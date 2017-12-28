class AddColumnToPhotos2 < ActiveRecord::Migration[5.0]
  def change
    add_attachment :photos, :avatar
  end
end
