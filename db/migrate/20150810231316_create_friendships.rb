class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :initiator_id, :null => false
      t.integer :acceptor_id, :null => false
      t.string :status
      t.timestamps null: false
    end
    add_index :friendships, [:acceptor_id, :initiator_id]
  end
end
