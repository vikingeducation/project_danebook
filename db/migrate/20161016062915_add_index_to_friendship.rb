class AddIndexToFriendship < ActiveRecord::Migration[5.0]
  def change
    add_index(:friendships, [:initiator, :recipient], unique: true)
  end
end
