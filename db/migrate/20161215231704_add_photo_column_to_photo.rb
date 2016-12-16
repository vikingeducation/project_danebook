class AddPhotoColumnToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_attachment :photos, :photo
  end
end
