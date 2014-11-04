class RemoveWeirdColumnsFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :"{:null=>false}_file_name"
    remove_column :photos, :"{:null=>false}_content_type"
    remove_column :photos, :"{:null=>false}_file_size"
    remove_column :photos, :"{:null=>false}_updated_at"
  end
end
