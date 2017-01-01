class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.references :user

      t.timestamps null: false
    end
    add_index :likes, [:likeable_type, :likeable_id]
    add_index :likes, [:user_id, :likeable_id, :likeable_type], :unique => true
  end
end
