class AddProfilePicturesToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :prof_photo_id, :integer
    add_column :profiles, :cover_photo_id, :integer
  end
end
