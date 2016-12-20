class RemoveAvatarColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :avatar_id
    remove_column :profiles, :banner_id
  end
end
