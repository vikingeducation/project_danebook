class RenameForeignKeys < ActiveRecord::Migration[5.0]
  def change
    rename_column :likes, :user_id, :liker_id
    rename_column :likes, :post_id, :liked_post_id
    rename_column :posts, :user_id, :author_id
  end
end
