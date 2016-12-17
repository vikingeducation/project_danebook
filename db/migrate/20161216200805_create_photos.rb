class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.integer :owner_id
      t.timestamps
    end
    add_index :photos, :owner_id
  end
end
