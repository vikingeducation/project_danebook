class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :initiator_id
      t.integer :approver_id

      t.index :initiator_id
      t.index :approver_id

      t.timestamps null: false
    end
  end
end
