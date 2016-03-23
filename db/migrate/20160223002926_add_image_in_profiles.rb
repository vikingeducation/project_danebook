class AddImageInProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :cover_id, :integer
    add_column :profiles, :image_id, :integer
    add_index :profiles, :cover_id
    add_index :profiles, :image_id
  end
end
