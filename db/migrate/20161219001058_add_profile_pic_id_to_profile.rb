class AddProfilePicIdToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :profile_pic_id, :integer
  end
end
