class Paperclipattrs < ActiveRecord::Migration[5.0]
  def up
    add_attachment :photos, :file
  end

  def down
    remove_attachment :photo, :file
  end
end
