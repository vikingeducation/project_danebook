class AddIndexToLikes < ActiveRecord::Migration
  def change
    add_index :likes, [:likable_id, :likable_type]
  end
end
