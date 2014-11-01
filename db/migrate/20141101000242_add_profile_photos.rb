class AddProfilePhotos < ActiveRecord::Migration
  def change
    add_column :profiles, :photo_id, :integer
    add_column :profiles, :cover_photo_id, :integer
  end
end
