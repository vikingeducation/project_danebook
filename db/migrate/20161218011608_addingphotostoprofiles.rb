class Addingphotostoprofiles < ActiveRecord::Migration[5.0]
  def up
    add_column :profiles, :profile_photo_id, :integer
    add_column :profiles, :cover_photo_id, :integer
  end

  def down
    remove_column :profiles, :profile_photo_id, :integer
    remove_column :profiles, :cover_photo_id, :integer
  end
end
