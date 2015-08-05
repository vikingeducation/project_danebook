class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, null: false
      t.integer :likings_id, null: false
      t.string :likings_type, null: false
      t.timestamps null: false
    end
    add_index :likes, [:likings_id, :likings_type], :unique => true
    add_index :likes, :created_at
  end
end
