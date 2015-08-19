class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :owner_id, null: false
      t.timestamps null: false
    end
  end
end
