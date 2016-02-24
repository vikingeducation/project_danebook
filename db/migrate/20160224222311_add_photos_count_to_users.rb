class AddPhotosCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photos_count, :integer, default: 0, null: false
  end
end
