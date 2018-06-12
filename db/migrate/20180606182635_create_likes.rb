class CreateLikes < ActiveRecord::Migration[5.0]
  def up
    create_table :likes do |t|
      t.references :likable, polymorphic: true
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
    add_index :likes, :user_id
  end
  def down
    drop_table :likes
  end
end
