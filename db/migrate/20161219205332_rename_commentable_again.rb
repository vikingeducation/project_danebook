class RenameCommentableAgain < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :commentable_thing_id, :commentable_id
    rename_column :comments, :commentable_thing_type, :commentable_type
  end
end
