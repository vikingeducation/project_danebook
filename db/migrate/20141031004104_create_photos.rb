class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :author_id, null: false
      t.attachment :photo, null: false
      t.integer :likes_count, default: 0, null: false

      t.timestamps
    end

    add_index :photos, :author_id
  end
end
