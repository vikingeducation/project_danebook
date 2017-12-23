class Friending < ActiveRecord::Migration[5.0]
  def change
    create_table :friendings do |t|
      t.integer :friend_id, :null => false
      t.integer :friender_id, :null => false
      t.timestamps
    end
  end
end
