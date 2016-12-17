class AddIndicesToFriendings < ActiveRecord::Migration[5.0]
  def change
    add_index :friendings, [:friender_id, :friended_id]
  end
end
