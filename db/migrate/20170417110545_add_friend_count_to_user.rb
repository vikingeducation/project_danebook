class AddFriendCountToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :friendships_count, :integer, default: 0
  end
end
