class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.integer :initiator
      t.integer :recipient

      t.timestamps
    end
  end
end
