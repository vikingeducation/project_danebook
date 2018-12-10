class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.belongs_to :friender
      t.belongs_to :friendee

      t.index [:friender_id, :friendee_id], unique: true
      t.timestamps
    end
  end
end
