class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.integer :initiator_id
      t.integer :approver_id
      t.boolean :approved

      t.index :initiator_id
      t.index :approver_id

      t.timestamps null: false
    end
  end
end
