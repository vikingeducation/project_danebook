class AddLikesCountToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :likes_count, :integer
  end
end
