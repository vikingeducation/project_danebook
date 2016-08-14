class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.integer :likeable_id
      t.string :likeable_type

      t.timestamps
    end
    add_index :likes, [:likeable_type, :likeable_id]
  end
end
