class UpdateUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phofile_photo_id, :integer
    add_column :users, :cover_photo_id, :integer
    remove_column :users, :username
  end
end
