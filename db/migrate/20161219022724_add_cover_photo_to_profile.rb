class AddCoverPhotoToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :cover_photo_id, :integer
  end
end
