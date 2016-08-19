class AddImagesToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :picture_id, :integer
    add_column :profiles, :cover_id, :integer
  end
end
