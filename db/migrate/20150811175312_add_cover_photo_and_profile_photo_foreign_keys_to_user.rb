class AddCoverPhotoAndProfilePhotoForeignKeysToUser < ActiveRecord::Migration
  def change
    add_column :users, :cover_photo_id, :integer
    add_column :users, :profile_photo_id, :integer
  end
end
