class CreateFriendings < ActiveRecord::Migration[5.0]
  def change
    create_table :friendings do |t|
      t.integer :friender_id
      t.integer :friended_id

      t.timestamps
    end
  end
end
