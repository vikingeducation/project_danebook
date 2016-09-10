class AddCoverPicToUser < ActiveRecord::Migration[5.0]
  def change
    add_attachment :users, :cover_image
  end
end
