class AddPictureToImages < ActiveRecord::Migration[5.0]
  def change
    add_attachment :images, :picture
  end
end
