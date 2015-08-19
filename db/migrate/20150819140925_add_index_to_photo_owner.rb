class AddIndexToPhotoOwner < ActiveRecord::Migration
  def change
    add_index :photos, :owner_id
  end
end
