class AddProfilePicturesToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_attachment :profiles, :profile_picture
  end
end
