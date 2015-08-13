class RemovePhotoColumnts < ActiveRecord::Migration
  def change
    remove_column :photos, :filename
    remove_column :photos, :mime_type
    remove_column :photos, :data
  end
end
