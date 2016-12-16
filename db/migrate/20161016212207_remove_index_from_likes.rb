class RemoveIndexFromLikes < ActiveRecord::Migration[5.0]
  def change
    remove_index(:likes, [:user_id, :likable_id])
  end
end
