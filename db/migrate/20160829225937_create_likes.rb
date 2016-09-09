class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :likable_id
      t.integer :liker_id

      t.timestamps
    end
    change_column :likes, :likable_id, :integer, :null => false
    change_column :likes, :liker_id, :integer, :null => false
  end
end
