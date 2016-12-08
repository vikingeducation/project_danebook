class AddProfileCoverUserIdToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :profile_user_id, :integer
    add_column :photos, :cover_user_id, :integer
  end
end
