class AddColumnToFriendship < ActiveRecord::Migration[5.0]
  def change
    add_column :friendships, :rejected, :boolean, null: true
  end
end
