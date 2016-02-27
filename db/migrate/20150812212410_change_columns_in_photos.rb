class ChangeColumnsInPhotos < ActiveRecord::Migration
  def change
    remove_column :profiles, :cover_file_name
    remove_column :profiles, :cover_content_type
    remove_column :profiles, :cover_file_size
    remove_column :profiles, :cover_updated_at
    remove_column :profiles, :avatar_file_name
    remove_column :profiles, :avatar_content_type
    remove_column :profiles, :avatar_file_size
    remove_column :profiles, :avatar_updated_at
    

    add_column :profiles, :cover_id, :integer
    add_column :profiles, :avatar_id, :integer



  end
end
