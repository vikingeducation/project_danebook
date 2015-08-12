class AddColumnsUserIdToPhotos < ActiveRecord::Migration
  def change
    add_attachment :photos, :photo
    add_column :photos, :user_id, :integer
  end
end
