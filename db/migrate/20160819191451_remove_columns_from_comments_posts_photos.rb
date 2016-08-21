class RemoveColumnsFromCommentsPostsPhotos < ActiveRecord::Migration
  def change
    remove_column :comments, :post_id
    remove_column :comments, :photo_id
    drop_table :feeds
  end
end
