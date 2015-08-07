class AddIndexToLikesPolymorph < ActiveRecord::Migration
  def change
  end
  add_index :likes, [:liked_id, :liked_type]
end
