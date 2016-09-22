class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :friender_id
      t.integer :friended_id
      t.timestamps
    end
    add_index :relationships, :friender_id
    add_index :relationships, :friended_id
    add_index :relationships, [:friender_id, :friended_id], unique: true
  end
end
