class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|


      t.belongs_to :user
      t.timestamps
    end

    add_attachment :photos, :image
  end
end
