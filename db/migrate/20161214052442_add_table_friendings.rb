class AddTableFriendings < ActiveRecord::Migration[5.0]
  def change
    create_table :friendings do |t|
      t.integer :friender_id, foreign_key: true
      t.integer :friended_id, foreign_key: true
    end
  end
end
