class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :friender_id
      t.integer :friended_id

      t.timestamps null: false
    end
    add_index :friendships, [:friender_id, :friended_id], unique: true
  end
end
