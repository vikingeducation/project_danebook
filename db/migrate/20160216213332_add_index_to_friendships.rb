class AddIndexToFriendships < ActiveRecord::Migration
  def change
    add_index :friendships, [:friend_requestor_id, :friend_receiver_id], unique: true, :name => 'friendhsip_index'
  end
end
