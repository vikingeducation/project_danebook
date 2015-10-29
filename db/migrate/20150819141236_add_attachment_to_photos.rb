class AddAttachmentToPhotos < ActiveRecord::Migration
  def change
    add_attachment :photos, :photo
  end
end
