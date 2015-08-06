class ChangeColNamesInLikes < ActiveRecord::Migration
  def change
  	rename_column :likes, :commentable_type, :liking_type
  	rename_column :likes, :commentable_id, :liking_id
  end
end
