class CreateFriendings < ActiveRecord::Migration[5.0]
  def change
    create_table :friendings do |t|
      t.integer :initiator_id
      t.integer :recipient_id

      t.timestamps
    end
    add_index :friendings, [:initiator_id, :recipient_id], :unique => true
  end
end
