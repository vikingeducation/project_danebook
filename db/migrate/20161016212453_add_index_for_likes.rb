class AddIndexForLikes < ActiveRecord::Migration[5.0]
  def change
    add_index(:likes, [:user_id, :likable_type, :likable_id], unique: true)
  end
end
