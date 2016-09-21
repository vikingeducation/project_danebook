class CreateFriendings < ActiveRecord::Migration[5.0]
  def change
    create_table :friendings do |t|
      t.integer :friended_id, :null => false
      t.integer :friender_id, :null => false

      t.timestamps
    end
    add_index :friendings, [:friended_id, :friender_id], :unique => true
  end
end
