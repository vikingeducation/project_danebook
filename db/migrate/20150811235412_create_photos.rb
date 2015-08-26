class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string  :filename
      t.string  :mime_type
      t.binary  :data


      t.timestamps null: false
    end
  end
end
