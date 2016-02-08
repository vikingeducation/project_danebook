class AddFieldsToPhoto < ActiveRecord::Migration
  def up
    add_attachment :photos, :uploaded_file
  end

  def down
    remove_attachment :photos, :uploaded_file
  end
end
