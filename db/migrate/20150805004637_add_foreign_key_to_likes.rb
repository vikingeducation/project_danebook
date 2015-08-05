class AddForeignKeyToLikes < ActiveRecord::Migration
  def change
    rename_column :likes, :users_id, :user_id
    add_foreign_key :likes, :user_id
  end
end
