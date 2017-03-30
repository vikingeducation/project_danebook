class FixUserProfilePhoto < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :phofile_photo_id
    add_column :users, :profile_photo_id, :integer
  end
end
