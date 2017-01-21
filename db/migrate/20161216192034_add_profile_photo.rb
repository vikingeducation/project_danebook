class AddProfilePhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :photo_id, :integer
    add_index :profiles, :photo_id
  end

end
