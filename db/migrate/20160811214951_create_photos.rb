class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :profile, foreign_key: true
      t.string :url
      t.timestamps
    end
  end
end
