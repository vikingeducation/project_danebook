class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :likable_id
      t.string :likable_type
      t.integer :user_id

      t.timestamps
    end

    add_index :likes, [:likable_id, :likable_type]
  end
end
