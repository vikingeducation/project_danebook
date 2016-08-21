class RemoveUserColumnsFromPhotoNPost < ActiveRecord::Migration
  def change
    remove_column :posts, :user_id, :integer
    remove_column :photos, :user_id, :integer
  end
end
