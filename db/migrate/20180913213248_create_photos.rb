class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.attachment :photo
      t.belongs_to :user

      t.timestamps
    end
  end
end
