class AddAttachmentsToProfile < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :avatar_id
    remove_column :profiles, :cover_id
    add_attachment :profiles, :avatar
    add_attachment :profiles, :cover
  end
end
