class AddColumnsAvatarCoverToProfile < ActiveRecord::Migration
  def change
      add_attachment :profiles, :cover
      add_attachment :profiles, :avatar
  end
end
