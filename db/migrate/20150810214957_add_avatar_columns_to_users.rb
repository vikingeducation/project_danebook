class AddAvatarColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_pic, :integer
    add_column :users, :cover_photo, :integer
  end
end
