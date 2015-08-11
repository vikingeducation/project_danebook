class AddAvatarColumnsToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :profile_pic
    add_attachment :users, :cover_photo
  end
end
