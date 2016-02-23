class Addcols < ActiveRecord::Migration
  def change
    add_column :users, :avatar_id, :integer
    add_column :users, :cover_photo_id, :integer
  end
end
