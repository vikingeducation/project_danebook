class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id, null: false
      t.string :event, null: false
      t.integer :activable_id, null: false
      t.string :activable_type, null: false

      t.timestamps null: false

      t.index [:user_id, :activable_id, :activable_type], unique: true
    end
  end
end
