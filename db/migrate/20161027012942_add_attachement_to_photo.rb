class AddAttachementToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_attachment :photos, :image
    add_column :photos, :user_id, :integer, :null => false
  end
end
