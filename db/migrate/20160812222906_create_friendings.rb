class CreateFriendings < ActiveRecord::Migration
  def change
    create_table :friendings do |t|
      t.integer :friend_id
      t.integer :friender_id

      t.timestamps null: false
    end
    add_index :friendings, [:friend_id, :friender_id], :unique => true
  end
end
