class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id, null: false
      t.attachment :image
      t.timestamps null: false
    end
  end
end
