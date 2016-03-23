class CreateFriendings < ActiveRecord::Migration
  def change
    create_table :friendings do |t|
      t.integer :friender_id, null: false
      t.integer :friended_id, null: false

      t.index [:friender_id, :friended_id], unique: true
      
      t.timestamps null: false
    end
  end
end
