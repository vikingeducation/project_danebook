class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.binary :data
      t.string :filename
      t.string :mime_type

      t.timestamps null: false
    end
  end
end
