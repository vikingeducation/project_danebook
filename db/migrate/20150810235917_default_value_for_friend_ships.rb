class DefaultValueForFriendShips < ActiveRecord::Migration
  def change
    change_column :friendships, :status, :string,
                  :default => 'Pending'
  end
end
