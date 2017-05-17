class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.timestamps
    end
    add_attachment :photos, :photo
  end
end
