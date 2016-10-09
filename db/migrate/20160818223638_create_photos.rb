class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.has_attached_file :image
      t.string :user_id

      t.timestamps
    end
  end
end
