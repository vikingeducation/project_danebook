class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :activity_type
      t.integer :activity_id
      t.timestamps
    end
  end
end
