class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friendings do |t|
      t.integer :friender_id
      t.integer :friended_id
      t.timestamps
    end
  end
end
