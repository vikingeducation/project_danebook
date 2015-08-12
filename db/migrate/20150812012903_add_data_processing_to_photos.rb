class AddDataProcessingToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :data_processing, :boolean
  end
end
