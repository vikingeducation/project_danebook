class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id

      t.index :user_id

      t.timestamps null: false
    end
    add_attachment :photos, :file

    add_column :users, :profile_photo_id, :integer
    add_column :users, :cover_photo_id, :integer

    add_index :users, :profile_photo_id
    add_index :users, :cover_photo_id
  end
end
