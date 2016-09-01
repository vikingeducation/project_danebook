class EditIndexOnLikes < ActiveRecord::Migration[5.0]
  def change
    remove_index :likes, [:likeable_id, :likeable_type]
    add_index :likes, [:likeable_id, :likeable_type], unique: true
  end
end
