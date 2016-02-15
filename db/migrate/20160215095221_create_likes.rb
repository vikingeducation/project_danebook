class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :likeable_id, null: false
      t.string :likeable_type, null: false

      t.index [:user_id, :likeable_id, :likeable_type], unique: true

      t.timestamps null: false
    end
  end
end
