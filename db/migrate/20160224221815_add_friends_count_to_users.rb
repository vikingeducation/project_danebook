class AddFriendsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friendings_count, :integer, default: 0, null: false
  end
end
