class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.references :likeable, :polymorphic => true

      t.timestamps null: false
    end
     add_index :likes, [:likeable_type, :likeable_id]
  end
end
