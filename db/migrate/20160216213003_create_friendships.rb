class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :friend_requestor_id, :null => false
      t.integer :friend_receiver_id, :null => false
    end
  end
end
