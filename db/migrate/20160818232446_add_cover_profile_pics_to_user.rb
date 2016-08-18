class AddCoverProfilePicsToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_pic_id, :integer
    add_column :users, :cover_pic_id, :integer
  end
end
