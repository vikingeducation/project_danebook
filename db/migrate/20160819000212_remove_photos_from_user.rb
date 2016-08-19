class RemovePhotosFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :users, :profile_photo
    remove_attachment :users, :cover_photo
  end
end
