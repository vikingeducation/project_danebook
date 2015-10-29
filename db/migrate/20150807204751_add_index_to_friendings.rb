class AddIndexToFriendings < ActiveRecord::Migration
  def change
  end
  add_index :friendings, [:friender_id, :friend_id], :unique => true
end
