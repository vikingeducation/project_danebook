class AddPhotosToLikes < ActiveRecord::Migration
  def change
    remove_column :likes, :likeable_type

    add_column :likes, :likeable_type, :string, null: false, inclusion: { in: ["Post", "Comment", "Photo"]}
  end 
end
