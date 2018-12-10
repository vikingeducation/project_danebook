class AddIndexToPostsUpdatedAt < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, :updated_at 
  end
end
