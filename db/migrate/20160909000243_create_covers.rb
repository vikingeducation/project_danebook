class CreateCovers < ActiveRecord::Migration[5.0]
  def change
    create_table :covers do |t|
      t.integer :photo_id, null:false
      t.integer :user_id, null: false, unique: true
      t.timestamps
    end
  end
end
