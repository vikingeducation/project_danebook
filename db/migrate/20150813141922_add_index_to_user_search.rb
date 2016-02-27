class AddIndexToUserSearch < ActiveRecord::Migration
  def change
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :posts, :user_id
    add_index :likes, :user_id
    add_index :photos, :user_id
  end
end
