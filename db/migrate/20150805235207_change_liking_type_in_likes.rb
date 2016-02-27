class ChangeLikingTypeInLikes < ActiveRecord::Migration
  def change
    change_column :likes, :liking_type, :string 
    change_column :comments, :commenting_type, :string 
  end
end
