class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user
      t.integer :likable_id
      t.string :likable_type

      t.timestamps null: false
    end

    add_index :likes, [:likable_type, :likable_id]
  end
end
