class AddPhotoData < ActiveRecord::Migration
  def change
    add_attachment :photos, :data
  end
end
