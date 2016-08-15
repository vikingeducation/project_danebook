class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.string :likeable_type
      t.integer :likeable_id
      t.references :user
      t.timestamps
    end
    add_index :likes, [:likeable_id, :likeable_type]
  end
end
