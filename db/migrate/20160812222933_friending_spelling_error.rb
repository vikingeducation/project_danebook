class FriendingSpellingError < ActiveRecord::Migration[5.0]
  def change
    rename_column :friendings, :initiatior_id, :initiator_id
  end
end
