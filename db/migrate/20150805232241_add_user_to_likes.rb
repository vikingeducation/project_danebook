class AddUserToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :user_id, :integer
    add_column :likes, :liking_id, :integer
    add_column :likes, :liking_type, :integer
  end
end
