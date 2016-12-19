class AddAvatarReferenceToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :avatar_id, :integer
    add_column :profiles, :banner_id, :integer
  end
end
