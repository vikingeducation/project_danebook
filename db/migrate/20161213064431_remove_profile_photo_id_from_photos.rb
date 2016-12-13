class RemoveProfilePhotoIdFromPhotos < ActiveRecord::Migration[5.0]
  def change
    remove_column :photos, :profile_user_id
    remove_column :photos, :cover_user_id
  end
end
