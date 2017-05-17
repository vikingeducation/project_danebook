class AddPhotoColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profile_photo, :integer
    add_column :users, :cover_photo, :integer
  end
end
