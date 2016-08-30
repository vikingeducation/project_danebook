class Indexpoly < ActiveRecord::Migration[5.0]
  def change
    add_index :likes, [:likable_type, :likable_id]
  end
end
