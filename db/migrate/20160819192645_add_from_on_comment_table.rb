class AddFromOnCommentTable < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :from, :integer
    add_column :likes, :from, :integer
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id
    add_column :photos, :user_id, :integer
    add_index :photos, :user_id
    remove_column :photos, :profile_id
  end
end
