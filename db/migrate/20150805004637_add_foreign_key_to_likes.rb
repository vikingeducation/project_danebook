class AddForeignKeyToLikes < ActiveRecord::Migration
  def change
    rename_column :likes, :users_id, :user_id
  end
end
