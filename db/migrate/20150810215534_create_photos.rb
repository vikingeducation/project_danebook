class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.attachment :data, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
