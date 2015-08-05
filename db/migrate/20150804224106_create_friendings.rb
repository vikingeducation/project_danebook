class CreateFriendings < ActiveRecord::Migration
  def change
    create_table :friendings do |t|
      t.integer :user_id
      t.integer :friend_id
      t.timestamps null: false
    end
    add_index :friendings, [:user_id, :friend_id], unique: true
  end
end
