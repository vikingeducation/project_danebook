class AddNullFalseFriendship < ActiveRecord::Migration[5.0]
  def change
    change_column_null(:friendships, :initiator, false)
    change_column_null(:friendships, :recipient, false)
  end
end
