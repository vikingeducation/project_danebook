class AddPhotoToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :photo_url , :string
    add_column :profiles, :background_url , :string
  end
end
