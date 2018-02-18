class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.string :likeable_type
      t.integer :likeable_id

      t.timestamps
    end
    add_index :likes, [:user_id, :likeable_type, :likeable_id] 
  end
end
