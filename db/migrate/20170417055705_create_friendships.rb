class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.integer :friender_id, null: false
      t.integer :friendee_id, null: false
      t.index [:friender_id, :friendee_id], unique: true
      t.timestamps
    end
  end
end
