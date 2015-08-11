class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user, null: false
      t.attachment :picture
      t.timestamps null: false
    end
  end
end
