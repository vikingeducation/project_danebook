class DropCOmmentLikesTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :comment_likes do |c|
      c.integer :user_id
      c.integer :comment_id
    end
    rename_column :comments, :comment_likes_count, :likes_count
  end
end
