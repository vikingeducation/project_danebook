class RenamePaperclipAttachmentOnPhotos < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :photos, :photo
    add_attachment :photos, :image
  end
end
