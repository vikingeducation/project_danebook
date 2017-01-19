class AddPictureProcessingToImage < ActiveRecord::Migration[5.0]
  def self.up
    add_column :images, :picture_processing, :boolean
  end

  def self.down
    remove_column :images, :picture_processing
  end
end
