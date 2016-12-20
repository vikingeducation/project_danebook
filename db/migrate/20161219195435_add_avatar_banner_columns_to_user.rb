class AddAvatarBannerColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_id, :integer
    add_column :users, :banner_id, :integer
  end
end
