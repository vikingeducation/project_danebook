class MakeUserIdReference < ActiveRecord::Migration
  def change
    remove_column :posts, :user_id
    add_foreign_key :posts, :users
  end
end
