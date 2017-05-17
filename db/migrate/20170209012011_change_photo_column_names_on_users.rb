class ChangePhotoColumnNamesOnUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :profile_photo, :profile_photo_id
    rename_column :users, :cover_photo, :cover_photo_id
  end
end
