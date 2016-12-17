class AddIndicesToLikeKeys < ActiveRecord::Migration[5.0]
  def change
  end
  add_index :likes, [:likable_type, :likable_id]
end
