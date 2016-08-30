class CreateProfilePhotos < ActiveRecord::Migration
  def change
    create_table :profile_photos do |t|
      t.references :profile, index: true, foreign_key: true, null: false
      t.references :photo, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
