class CreateFriendRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :friend_requests do |t|
      t.integer :user_one_id, null: false
      t.integer :user_two_id, null: false
      t.integer :status_id, null: false

      t.timestamps
    end

    add_index :friend_requests, [:user_one_id, :user_two_id], unique: true
  end
end
