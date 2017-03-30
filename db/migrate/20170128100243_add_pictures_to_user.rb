class AddPicturesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :picture_id, :integer
    add_column :profiles, :cover_id, :integer
  end
end
