class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.integer :user_id, null: false
      t.integer :like_count, default: 0

      t.timestamps
    end
  end
end
