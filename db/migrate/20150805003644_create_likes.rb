class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user
      t.integer :likings_id
      t.string :likings_type
      t.timestamps null: false
    end
    add_index :likes, [:likings_id, :likings_type]
    add_index :likes, :created_at
  end
end
