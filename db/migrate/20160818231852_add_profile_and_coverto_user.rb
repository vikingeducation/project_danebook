class AddProfileAndCovertoUser < ActiveRecord::Migration[5.0]
  def change
    add_attachment :users, :profile_photo
    add_attachment :users, :cover_photo
  end
end
