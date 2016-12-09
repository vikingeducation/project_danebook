class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.integer :friender_id
      t.integer :friendee_id
      t.boolean :accepted, default: false

      t.timestamps
    end
        add_index :friends, [:friendee_id, :friender_id], :unique => true
  end
end
