class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.attachment :avatar
      t.boolean :profile
      t.boolean :cover
      t.timestamps
    end
  end
end
