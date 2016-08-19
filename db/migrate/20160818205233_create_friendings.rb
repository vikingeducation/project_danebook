class CreateFriendings < ActiveRecord::Migration[5.0]
  def change
    create_table :friendings do |t|
      t.integer :friender
      t.integer :friendee

      t.timestamps
    end
    add_index :friendings, [ :friender, :friendee ], :unique => true
  end
end
