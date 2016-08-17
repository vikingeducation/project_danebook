class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.integer :friender_id
      t.integer :friended_id

      t.timestamps
    end

    add_index :friendships, [:friender_id, :friended_id]
  end
end
